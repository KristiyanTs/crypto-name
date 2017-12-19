jQuery(document).ready(function(){
  $('.range-slider__value').html(15);
  $('.range-slider .range-slider__range').on('input', function() { 
    $('.range-slider__value').html(this.value);
  });
});




