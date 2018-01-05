document.addEventListener("turbolinks:load", function() {
  $('.product .footer').toggle();
  $('.filter-topdomain input:checkbox').prop('checked', true);

  $('.product .clickable').on("click tap", function(){
    $('.product .clickable').not(this).each(function(){
       var footer = $(this).next('.footer');
       var product = $(this).parent().parent();

       footer.hide();
       product.removeClass('faded').removeClass('active');
    });

    var product = $(this).parent().parent()
    product.toggleClass('active').removeClass('faded');
    var footer = $(this).next('.footer');
    footer.toggle(100);

    if(product.hasClass('active')){
      $('.product').not(product).each(function(){
         $(this).addClass('faded');
      });
    } else{
      $('.product').removeClass('faded');
    }

  });

  $('.product .footer').on("click tap", function(event){
    event.stopPropagation();
  });

  $('.buy-domain .range-slider input').on('input', function() { 
    var period = this.value;

    if(period==1){
      period = period + " year for ";
    }
    else{
      period = period + " years for ";
    }

    var total = $(this).parent().parent().next();
    var years = total.children('.years');
    var price = total.children('.price');
    years.html(period);
    price.html(" $14.99");
  });


  $('.filter-topdomain input').on("click tap", function(){
    $('.product').removeClass('faded').removeClass('active');
    $('.product .footer').hide();

    if($(this).hasClass('all')){
      if($(this).is(':checked')){
        $('.filter-topdomain input:checkbox').prop('checked', this.checked);
      } else{
        $('.filter-topdomain input:checkbox').prop('checked', false);
      }
    } else{
      if(!$(this).is(':checked')){
        $('.filter-topdomain input.all:checkbox').prop('checked', false);
      }
    }
    filter();
  });

  function filter(){
    var extension;
    var inputs = $('.filter-topdomain input:checked');

    $('.product').hide();
    inputs.each(function(){
      extension = $(this).attr("class");
      $('.product').each(function(){
        if($(this).hasClass(extension)){
          $(this).show();
        }
      });
    })
  } 

})