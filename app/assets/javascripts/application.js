// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require materialize-sprockets
//= require ckeditor/init
$(document).ready(function(){
  $('.dropdown-button').dropdown();
   $('select').material_select('destroy');
});

$(document).ready(function(){
  $('.left-sitebar .list-class .class-item').on('click',function(){
    $('.left-sitebar .list-class .class-item').css('width','33.3333333333%');
    $('.left-sitebar .list-class .class-item').find('.row')
      .css('display','none');
    $(this).css('width','100%');
    $(this).find('.row').css('display','block');
  });
});

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
    $(this).css('display','none');
    $('.add-answer').css('display','block');
  });
});

$(document).ready(function(){
  $('.btn-add-comment').on('click',function(){
    var parent = $(this).closest('table').attr('id');
    $('#'+parent+' '+'.btn-add-comment').css('display','none');
    $('#'+parent+' '+'.add-comment').css('display','block');
  });
});
