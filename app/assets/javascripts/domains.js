document.addEventListener("turbolinks:load", function() {
  $('.edit_record').on('change', function(){
    $(this).submit();
  });
});

