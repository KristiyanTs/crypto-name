document.addEventListener("turbolinks:load", function() {
  $("body .cart-button").on('click tap', function(){
    if($(this).hasClass('opened')){
      $('.cart').hide();
      $('.content-wrapper').show();
    }else{
      $('.content-wrapper').hide();
      $('.cart').removeClass('hidden');
      $('.cart').show();
    }
  });

  $('.cart .item form').on('change', function(){
    $(this).submit();
  });
});