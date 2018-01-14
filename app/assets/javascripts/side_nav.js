document.addEventListener("turbolinks:load", function() {
  $('.has-children a.trigger').on('click tap', function(event){
    event.preventDefault();
    $(this).toggleText('More', 'Less');
    $(this).next('ul').toggleClass('hidden');
  });
});