$(document).on('turbolinks:load',function() {
    $('#name_menu').on('click',function(){
        $('#name_form').toggle();
    });

    $('#password_menu').on('click',function(){
        $('#password_form').toggle();
    });
});