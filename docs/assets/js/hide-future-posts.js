// loop through all list items with a date
$('li[date]').each(function () {
    // parse the date
    var itemDate = new Date($(this).attr('date') + "T00:00:00Z");
    // compare dates and hide future posts
    if (itemDate > Date.now()) $(this).hide();
});
