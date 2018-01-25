document.addEventListener("turbolinks:load", function() {
  $('.cart .item form').on('change', function(){
    $(this).submit();
  });
});

