(function run() {
    const plusSignButtons = Array.from(document.querySelectorAll('[data-testid="commerce-tile-button"][type="ico_add_circle"]'));

    const totalOffers = plusSignButtons.length;
    console.log(`🛍️ Total offers to add: ${totalOffers}`);

    let currentIndex = 0;

    function addNextOffer() {
        if (currentIndex >= totalOffers) {
            console.log("🎉 All offers with plus sign have been added. Enjoy your savings! 🎉");
            checkForNewOffers();
            return;
        }

        const addButton = plusSignButtons[currentIndex];
        addButton.click();

        // Use MutationObserver to watch for changes in the DOM
        const observer = new MutationObserver(() => {
            findAndClickBackButton(10); // Scan the entire page for the back button, with a limit of 10 attempts
            observer.disconnect(); // Disconnect the observer once the back button is found
        });

        observer.observe(document.body, { childList: true, subtree: true });
    }

    function findAndClickBackButton(remainingAttempts) {
        if (remainingAttempts <= 0) {
            console.log("❌ Maximum attempts reached. Exiting script.");
            return;
        }

        // Function to recursively search for the back button in all frames and overlays
        function searchInFrames(frames) {
            for (let i = 0; i < frames.length; i++) {
                const frame = frames[i];

                try {
                    // Access the document of the frame
                    const frameDocument = frame.contentDocument;

                    // Search for the back button in the current frame
                    const backButton = frameDocument.getElementById('back-button');
                    if (backButton && backButton.getAttribute('aria-label') === 'Back') {
                        console.log("✅ Back button found.");
                        backButton.click(); // Click the back button to return to the previous page
                        currentIndex++;
                        addNextOffer(); // Proceed to the next offer
                        return; // Exit the function after finding and clicking the back button
                    }

                    // Search within frames of the current frame
                    if (frame.frames.length > 0) {
                        searchInFrames(frame.frames);
                    }
                } catch (error) {
                    console.log(`Error accessing frame: ${error}`);
                }
            }
        }

        // Start searching in the top-level window and its frames
        searchInFrames(Array.from(window.frames));

        // Search for the back button in overlays
        const backButton = document.getElementById('back-button');
        if (backButton && backButton.getAttribute('aria-label') === 'Back') {
            console.log("✅ Back button found.");
            backButton.click(); // Click the back button to return to the previous page
            currentIndex++;
            addNextOffer(); // Proceed to the next offer
        } else {
            console.log(`❌ Back button not found. Retrying... Attempts remaining: ${remainingAttempts}`);
            setTimeout(() => {
                findAndClickBackButton(remainingAttempts - 1); // Retry after 1 second if the back button is not found
            }, 1000);
        }
    }

    function checkForNewOffers() {
        const newPlusSignButtons = Array.from(document.querySelectorAll('[data-testid="commerce-tile-button"][type="ico_add_circle"]'));

        if (newPlusSignButtons.length > totalOffers) {
            console.log(`ℹ️ Found ${newPlusSignButtons.length - totalOffers} new offers with plus sign. Adding them now...`);
            setTimeout(run, 1000); // Rerun the script after 1 second to add new offers
        } else {
            console.log("🔍 No new offers with plus sign found.");
        }
    }

    if (totalOffers > 0) {
        addNextOffer();
    } else {
        console.log("🎉 No offers with plus sign found. Enjoy your savings! 🎉");
    }
})();
