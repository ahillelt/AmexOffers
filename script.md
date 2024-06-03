```
(function run() {
    const offers = Array.from(document.querySelectorAll('[data-rowtype="offer"]'))
        .map(e => e.querySelector('button[title="Add to Card"]'))
        .filter(Boolean);

    const totalOffers = offers.length;
    console.log(`🛍️ Total offers to add: ${totalOffers}`);

    function addOfferWithDelay(index) {
        if (index >= totalOffers) {
            console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
            return;
        }

        const offerButton = offers[index];
        offerButton.click();

        setTimeout(() => {
            const offersLeft = totalOffers - index - 1;
            console.log(`✨ Offer added... ${offersLeft} more left! ✨`);
            addOfferWithDelay(index + 1); // Move to the next offer after a short delay
        }, 1000); // Delay in milliseconds (adjust as needed)
    }

    if (totalOffers > 0) {
        addOfferWithDelay(0); // Start adding offers from index 0
    } else {
        console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
    }
})();

```
