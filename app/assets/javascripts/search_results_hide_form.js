$(function onLoad() {
    if ($(document.body).hasClass('searches_controller')) {
        $('body').addClass('search-collapsed');
        $('.expand-button').click(function(){
            $('body').removeClass('search-collapsed');
            $('#suburbAutocomplete').focus().val($('#suburbAutocomplete').val());
        })
    }
});
