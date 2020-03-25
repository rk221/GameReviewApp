$(document).on('turbolinks:load',function() {
    $('.toggle_form').on('click',function(){
        $(this).children(".toggle_target").toggle();
    });
});