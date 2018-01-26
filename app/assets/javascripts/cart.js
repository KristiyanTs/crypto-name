document.addEventListener("turbolinks:load", function() {
  $('.cart .item form').on('change', function(){
    $(this).submit();
  });
  $('.cart-button').on('tap click', function(){
    if($(this).hasClass('closed')){
      $(this).removeClass('closed');
      $('.cart').removeClass('closed');
    } else {
      $(this).addClass('closed');
      $('.cart').addClass('closed');
    }
  });
});

