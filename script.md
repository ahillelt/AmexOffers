```
(function run() {
    const offers = Array.from(document.querySelectorAll('[data-rowtype="offer"]'))
        .map(e => e.querySelector('button[title="Add to Card"]'))
        .filter(Boolean);

    const totalOffers = offers.length;
    console.log(`🛍️ Total offers to add: ${totalOffers}`);

    let currentIndex = 0;

    function addNextOffer() {
        if (currentIndex >= totalOffers) {
            console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
            checkForNewOffers();
            return;
        }

        const offerButton = offers[currentIndex];
        offerButton.click();

        setTimeout(() => {
            console.log(`✨ Offer added... ${totalOffers - currentIndex - 1} more left! ✨`);
            currentIndex++;
            addNextOffer(); // Move to the next offer
        }, 1000); // Wait for 1 second for the page to update
    }

    function checkForNewOffers() {
        const newOffers = Array.from(document.querySelectorAll('[data-rowtype="offer"]'))
            .map(e => e.querySelector('button[title="Add to Card"]'))
            .filter(Boolean);

        if (newOffers.length > totalOffers) {
            console.log(`ℹ️ Found ${newOffers.length - totalOffers} new offers. Adding them now...`);
            setTimeout(run, 1000); // Rerun the script after 1 second to add new offers
        } else {
            console.log("🔍 No new offers found.");
        }
    }

    if (totalOffers > 0) {
        addNextOffer();
    } else {
        console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
    }
})();

```
