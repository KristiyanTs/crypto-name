document.addEventListener("turbolinks:load", function() {
  $('.domain-search input.autofocus').focus();
  $('.domain-search').submit(function(event){
    $('.cd-main-content .content-wrapper').append("<div class='wrap'><div class='loading'><div class='bounceball'></div><div class='text'>Searching. Please wait...</div></div></div>");
  })
})