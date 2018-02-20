document.addEventListener("turbolinks:load", function() {
  $('.edit_record').on('change', function(){
    $(this).submit();
  });
  $('.panel-title .domain-name').on('click tap mouseenter', function(){
    if(!$(this).data('loaded')){
      $(this).parent().parent().parent().find('form.check-availability').submit();
    }
    $(this).data('loaded', true);
  });
});

