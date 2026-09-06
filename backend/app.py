from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import os
import uuid
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)

CORS(app)

metrics = PrometheusMetrics(app)


def get_database():

    return mysql.connector.connect(

        host=os.getenv(
            "DB_HOST",
            "mysql"
        ),

        user=os.getenv(
            "DB_USER",
            "eventuser"
        ),

        password=os.getenv(
            "DB_PASSWORD",
            "eventpass"
        ),

        database=os.getenv(
            "DB_NAME",
            "eventdb"
        )

    )


@app.route("/health")
def health():

    return jsonify({
        "status": "Backend is running"
    })


@app.route("/events")
def get_events():

    db = get_database()

    cursor = db.cursor(
        dictionary=True
    )

    cursor.execute(
        "SELECT * FROM events"
    )

    events = cursor.fetchall()

    cursor.close()

    db.close()

    return jsonify(events)


@app.route("/book", methods=["POST"])
def book_ticket():

    data = request.get_json()


    name = data.get("name")

    email = data.get("email")

    phone = data.get("phone")

    event_name = data.get("event")

    quantity = data.get("quantity")


    if not name:

        return jsonify({
            "message":
            "Name is required"
        }), 400


    if not email:

        return jsonify({
            "message":
            "Email is required"
        }), 400


    if not phone:

        return jsonify({
            "message":
            "Phone is required"
        }), 400


    if not event_name:

        return jsonify({
            "message":
            "Event is required"
        }), 400


    if not quantity:

        return jsonify({
            "message":
            "Ticket quantity is required"
        }), 400


    try:

        quantity = int(quantity)

    except ValueError:

        return jsonify({
            "message":
            "Invalid ticket quantity"
        }), 400


    if quantity < 1 or quantity > 10:

        return jsonify({
            "message":
            "Tickets must be between 1 and 10"
        }), 400


    db = get_database()

    cursor = db.cursor(
        dictionary=True
    )


    cursor.execute(
        """
        SELECT price
        FROM events
        WHERE name = %s
        """,
        (event_name,)
    )


    event = cursor.fetchone()


    if not event:

        cursor.close()

        db.close()

        return jsonify({
            "message":
            "Event not found"
        }), 404


    price = float(
        event["price"]
    )


    total = price * quantity


    booking_id = (
        "EVT-"
        + uuid.uuid4().hex[:8].upper()
    )


    cursor.execute(
        """
        INSERT INTO bookings
        (
            booking_id,
            customer_name,
            email,
            phone,
            event_name,
            quantity,
            price,
            total_amount
        )
        VALUES
        (%s,%s,%s,%s,%s,%s,%s,%s)
        """,

        (
            booking_id,
            name,
            email,
            phone,
            event_name,
            quantity,
            price,
            total
        )
    )


    db.commit()


    cursor.close()

    db.close()


    return jsonify({

        "message":
        "Booking successful",

        "booking_id":
        booking_id,

        "customer": {

            "name": name,

            "email": email,

            "phone": phone

        },

        "event":
        event_name,

        "quantity":
        quantity,

        "price":
        price,

        "total":
        total

    })


if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000
    )
