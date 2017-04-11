$(document).ready(function(){
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id)
    });
  }
});

$(document).ready(function(){
  $('.choose_class').on('change',function(e){
    e.preventDefault();
    var class_id = this.value;
    $.ajax({
      type: "GET",
      url: "/categories/"+class_id,
      dataType: "json",
      success: function(data){
        $('.display_object').css("display","block").empty();
        for(var i=0; i<data.length; i++){
          $('.display_object').append('<option value="' + data[i]["id"] + '">' +
            data[i]["name"] + '</option> ');
        }
      }
    });
  });
});

$(document).ready(function(){
  $('.btn-add-answer').on('click',function(){
    $(this).css('display', 'none');
    $('.add-answer').css('display', 'block');
  });
});

$(document).ready(function(){
  $('.btn-add-comment').on('click', function(){
    var parent = $(this).closest('table').attr('id');
    $('#'+parent+' '+'.btn-add-comment').css('display', 'none');
    $('#'+parent+' '+'.add-comment').css('display', 'block');
  });
});
