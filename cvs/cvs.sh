(function run() {
    const couponElements = Array.from(document.querySelectorAll('send-to-card-action'));
    if (couponElements.length === 0) {
        console.log("ℹ️ No coupons found. Exiting...");
        return;
    }

    const coupons = couponElements
        .map(e => e.querySelector('.coupon-container .coupon-action.sc-send-to-card-action'))
        .filter(Boolean);

    const totalCoupons = coupons.length;
    console.log(`🛍️ Total coupons to add: ${totalCoupons}`);

    const TIMEOUT_INTERVAL = 350; // milliseconds

    coupons.forEach((coupon, index) => {
        setTimeout(() => {
            coupon.click();
            const couponsLeft = totalCoupons - index - 1;
            console.log(`✨ Coupon added... ${couponsLeft} more left! ✨`);
            if (couponsLeft === 0) {
                console.log("🎉 All coupons have been added to your card. Enjoy your savings! 🎉");
            }
        }, index * TIMEOUT_INTERVAL);
    });
})();
