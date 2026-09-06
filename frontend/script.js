const API_URL = "/api";

let currentPrice = 0;


function openBooking(
    eventName,
    price,
    date,
    location
) {

    currentPrice = price;

    document.getElementById(
        "selectedEvent"
    ).innerText = eventName;

    document.getElementById(
        "selectedDate"
    ).innerText = "📅 " + date;

    document.getElementById(
        "selectedLocation"
    ).innerText = "📍 " + location;

    document.getElementById(
        "eventName"
    ).value = eventName;

    document.getElementById(
        "ticketPrice"
    ).value = price;

    document.getElementById(
        "displayPrice"
    ).innerText = "₹" + price;

    document.getElementById(
        "quantity"
    ).value = 1;

    calculateTotal();

    document.getElementById(
        "bookingModal"
    ).style.display = "block";
}


function closeBooking() {

    document.getElementById(
        "bookingModal"
    ).style.display = "none";

}


function calculateTotal() {

    const quantity =
        parseInt(
            document.getElementById(
                "quantity"
            ).value
        ) || 1;

    const total =
        currentPrice * quantity;

    document.getElementById(
        "displayQuantity"
    ).innerText = quantity;

    document.getElementById(
        "totalAmount"
    ).innerText = "₹" + total;
}


document.getElementById(
    "bookingForm"
).addEventListener(
    "submit",
    async function(event) {

        event.preventDefault();


        const name =
            document.getElementById(
                "customerName"
            ).value;

        const email =
            document.getElementById(
                "email"
            ).value;

        const phone =
            document.getElementById(
                "phone"
            ).value;

        const eventName =
            document.getElementById(
                "eventName"
            ).value;

        const quantity =
            parseInt(
                document.getElementById(
                    "quantity"
                ).value
            );


        const response =
            await fetch(
                API_URL + "/book",
                {

                    method: "POST",

                    headers: {
                        "Content-Type":
                            "application/json"
                    },

                    body: JSON.stringify({

                        name: name,

                        email: email,

                        phone: phone,

                        event: eventName,

                        quantity: quantity

                    })

                }
            );


        const data =
            await response.json();


        if (!response.ok) {

            alert(data.message);

            return;

        }


        document.getElementById(
            "bookingModal"
        ).style.display = "none";


        document.getElementById(
            "billBookingId"
        ).innerText = data.booking_id;


        document.getElementById(
            "billName"
        ).innerText = data.customer.name;


        document.getElementById(
            "billEmail"
        ).innerText = data.customer.email;


        document.getElementById(
            "billPhone"
        ).innerText = data.customer.phone;


        document.getElementById(
            "billEvent"
        ).innerText = data.event;


        document.getElementById(
            "billTickets"
        ).innerText = data.quantity;


        document.getElementById(
            "billPrice"
        ).innerText = data.price;


        document.getElementById(
            "billTotal"
        ).innerText = data.total;


        document.getElementById(
            "billModal"
        ).style.display = "block";

    }
);


function closeBill() {

    document.getElementById(
        "billModal"
    ).style.display = "none";

}


window.onclick = function(event) {

    const bookingModal =
        document.getElementById(
            "bookingModal"
        );

    const billModal =
        document.getElementById(
            "billModal"
        );


    if (event.target === bookingModal) {

        closeBooking();

    }


    if (event.target === billModal) {

        closeBill();

    }

};
