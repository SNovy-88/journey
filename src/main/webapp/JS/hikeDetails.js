function highlightRecommendedMonths(monthsBitmask){
    $('.month').each(function () {
        let month = parseInt($(this).data('month')); // month is value 1 to 2048
        let monthElement = $(this);

        if((monthsBitmask & month) !== 0) {
            monthElement.css('background-color', '#b1ff2e');
        }
    });
}