//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-ui
//= require turbolinks
//= require_tree .

$.fn.extend({
    toggleText: function(a, b){
        return this.text(this.text() == b ? a : b);
    }
});

// scroll to a given element
document.addEventListener("turbolinks:load", function() {
  $('.smooth-scroll').on('click tap', function(e){
    e.preventDefault();
    var destination = $(this).data('destination');
    document.querySelector(destination).scrollIntoView({ 
      behavior: 'smooth' 
    });
  });
});

