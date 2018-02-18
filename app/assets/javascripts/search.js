document.addEventListener("turbolinks:load", function() {
  $('.domain-search input.autofocus').focus();
  $('.domain-group').hide();
  $('.add-to-cart').on('click tap', function(){
    $(this).addClass('disabled');
    $(this).click(false);
  });
  $('.domain-category a').on('click tap', function(){
    var category = $(this).data('category');
    $('.domain-search #category').val(category);
    $('.domain-search').submit();
  });
});