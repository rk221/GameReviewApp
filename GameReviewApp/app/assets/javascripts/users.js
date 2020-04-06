$(document).on('turbolinks:load',function() {
    $('.toggle_form button').on('click',function(){
        $(this).parent().children(".toggle_target").toggle();
    });
});