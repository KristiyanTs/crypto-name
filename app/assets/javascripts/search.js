document.addEventListener("turbolinks:load", function() {
  $('.domain-search input.autofocus').focus();
  $('.domain-group').hide();
  $('.add-to-cart').on('click tap', function(){
    $(this).addClass('disabled');
    $(this).click(false);
  });
});