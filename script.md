```
(function run() {
    const offers = Array.from(document.querySelectorAll('[data-rowtype="offer"]'))
        .map(e => e.querySelector('button[title="Add to Card"]'))
        .filter(Boolean);

    const totalOffers = offers.length;
    console.log(`🛍️ Total offers to add: ${totalOffers}`);

    offers.forEach((e, index) => {
        setTimeout(() => {
            e.click();
            const offersLeft = totalOffers - index - 1;
            console.log(`✨ Offer added... ${offersLeft} more left! ✨`);
            if (offersLeft === 0) {
                console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
            }
        }, index * 350);
    });

    if (totalOffers === 0) {
        console.log("🎉 All offers have been added to your card. Enjoy your savings! 🎉");
    }
})();
```
