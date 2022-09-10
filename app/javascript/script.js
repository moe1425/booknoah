$(document).on('turbolinks:load', function() {
    $('.hum-menu').click(function () {
        $('.side-menu').toggleClass('d-none')
    })
    
    $('.side-menu').click(function () {
        $('.hum-menu').toggleClass('d-none')
    })
});
