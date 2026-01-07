// loop through all list items with a date
$('li[date]').each(function () {
    // parse the date
    var itemDate = new Date($(this).attr('date') + "T00:00:00Z");
    // compare dates and hide future posts
    var show_future = document.currentScript.getAttribute("data-show-future");
    if (show_future != "true") {
        if (itemDate > Date.now()) $(this).hide();
    };
});
