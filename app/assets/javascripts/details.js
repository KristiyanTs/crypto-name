document.addEventListener("turbolinks:load", function() {
  $('.details-form').hide();
  $('.add-details').on('click tap', function(event){
    event.preventDefault();
    $('.details-form').show();
  })
})