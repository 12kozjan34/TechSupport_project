$(document).ready(function () {
    $(".accordion-item").click(function () {
        $(this).find(".additional-info").slideToggle();
        $(".accordion-item").not(this).find(".additional-info").slideUp();
    });
});