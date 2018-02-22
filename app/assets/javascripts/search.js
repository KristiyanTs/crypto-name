document.addEventListener("turbolinks:load", function() {
  $('.domain-search input.autofocus').focus();
  $('.add-to-cart').on('click tap', function(){
    $(this).addClass('disabled');
    $(this).click(false);
  });
  $('.domain-category a').on('click tap', function(){
    var category = $(this).data('category');
    $('.domain-search #category').val(category);
    $('.domain-search').submit();
    $('.domain-group').fadeOut(100).fadeIn(300);
  });
});