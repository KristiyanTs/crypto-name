document.addEventListener("turbolinks:load", function() {
  $('.add-details').on('click tap', function(event){
    event.preventDefault();
    $('.details-form').removeClass('hidden');
  })
})