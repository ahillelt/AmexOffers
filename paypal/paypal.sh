(function run() {
    let retries = 0;

    function clickShowMore() {
        const showMoreButtons = document.querySelectorAll('button[data-cy="tertiary_card_list__show_more_button"]');
        if (showMoreButtons.length > 0) {
            showMoreButtons.forEach(button => {
                button.click();
            });
            setTimeout(() => {
                console.log("All offers showing, selecting offers...");
                scanOffers();
                clickShowMore();
            }, 2000);
        } else if (retries < 3) {
            retries++;
            setTimeout(clickShowMore, 3000);
        } else {
            console.log("No more offers to show.");
        }
    }

    function scanOffers() {
        const offerTiles = document.querySelectorAll('section[id^="shopping-view-"]');
        if (offerTiles.length === 0) {
            console.log("No offers found.");
            return;
        }

        offerTiles.forEach((tile, index) => {
            setTimeout(() => {
                const saveOfferButton = tile.querySelector('button[data-ppui-info^="icon-button_"]');
                if (saveOfferButton) {
                    saveOfferButton.click();
                }
            }, index * 500);
        });
    }

    clickShowMore();
})();
