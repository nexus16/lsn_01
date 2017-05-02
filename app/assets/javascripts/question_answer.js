$(document).on('turbolinks:load', function(){
  if ($('textarea').length > 0) {
    var data = $('.ckeditor');
    $.each(data, function(i) {
      CKEDITOR.replace(data[i].id)
    });
  }
});

$(document).on('change', '.choose-class', function(e){
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

$(document).on('click', '.btn-add-answer', function(){
  $(this).css('display', 'none');
  $('.add-answer').css('display', 'block');
});

$(document).on('click', '.btn-add-comment', function(){
  var parent = $(this).closest('article').attr('id');
  $('#' + parent + ' ' + '.btn-add-comment').css('display', 'none');
  $('#' + parent + ' ' + '.add-comment').css('display', 'block');
});

$(document).on('click', '.btn-edit-answer', function(){
  var parent = $(this).closest('article').attr('id');
  $('#' + parent + ' ' + 'h5').css('display', 'none');
  $('#' + parent + ' ' + '.edit-answer').css('display', 'block');
});

$(document).on('click', '.btn-edit-comment', function(){
  var parent = $(this).closest('div.collection').attr('class').slice(11);
  $('.' + parent + ' ' + 'p').css('display', 'none');
  $('.' + parent + ' ' +'.edit-comment').css('display', 'block');
});

$(document).on('click', '.btn-edit-answer', function(){
  var id_answer = $(this).closest('article').attr('data-answer');
  var id_question = $(this).closest('article').attr('data-question');
  $.ajax({
    type: 'GET',
    url: '/questions/' + id_question + '/answers/' + id_answer + '/edit',
    dataType: 'json',
    success: function(data){
      $('.edit-answer').html(
        '<form action="/questions/' + id_question + '/answers/' + id_answer +
        '" accept-charset="UTF-8" data-remote="true" method="post">'+
        '<input name="utf8" type="hidden" value="✓">' +
        '<input type="hidden" name="_method" value="patch">' +
        '<textarea name="answer[content]" id="answer_content">' + data.content
        + '</textarea>'+
        '<input type="submit">'+
        '</form>'
      );
    }
  });
});

$(document).on('click', '.btn-edit-comment', function(){
  var id_answer = $(this).closest('.secondary-content').attr('data');
  var id_question = $(this).closest('article').attr('data-question');
  $.ajax({
    type: 'GET',
    url: '/questions/' + id_question + '/answers/' + id_answer + '/edit',
    dataType: 'json',
    success: function(data){
      $('.edit-comment').html(
        '<form action="/questions/' + id_question + '/answers/' + id_answer +
        '" accept-charset="UTF-8" data-remote="true" method="post">'+
        '<input name="utf8" type="hidden" value="✓">' +
        '<input type="hidden" name="_method" value="patch">' +
        '<textarea name="answer[content]" id="answer_content">' + data.content
        + '</textarea>'+
        '<input type="submit">'+
        '</form>'
      );
    }
  });
});
