$(document).on('turbolinks:load', function(){
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id)
    });
  }
});

$(document).on('turbolinks:load', function(){
  $('.choose-class').on('change',function(e){
    e.preventDefault();
    var class_id = this.value;
    $.ajax({
      type: "GET",
      url: "/categories/"+class_id,
      dataType: "json",
      success: function(data){
        $('.display-object').css("display","block").empty();
        for(var i=0; i<data.length; i++){
          $('.display-object').append('<option value="' + data[i]["id"] + '">' +
            data[i]["name"] + '</option> ');
        }
      }
    });
  });
});

$(document).on('turbolinks:load', function(){
  $('.btn-add-answer').on('click',function(){
    $(this).css('display', 'none');
    $('.add-answer').css('display', 'block');
  });
});

$(document).on('turbolinks:load', function(){
  $('.btn-add-comment').on('click', function(){
    var parent = $(this).closest('table').attr('id');
    $('#'+parent+' '+'.btn-add-comment').css('display', 'none');
    $('#'+parent+' '+'.add-comment').css('display', 'block');
  });
});
