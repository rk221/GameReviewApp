$(document).on('turbolinks:load', function() {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('#image_prev').attr('src', e.target.result);
          console.log($('#image_prev').html());
        }
        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#review_image").change(function(){
      readURL(this);
    });
});