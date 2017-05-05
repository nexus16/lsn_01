$(document).on('turbolinks:load', function(){
  $('.admin-button-collapse').sideNav();
});

$(document).on('turbolinks:load', function() {
  $('.select-user-option-manager').material_select();
  $('.select-user-option-manager').on('change', function(e) {
    $.ajax({
      url: '/admin/users',
      type: 'get',
      data: {sort: this.value}
    });
  });
});

$(document).on('turbolinks:load', function() {
  $('.select-question-option-manager').material_select();
  $('.select-question-option-manager').on('change', function(e) {
    $.ajax({
      url: '/admin/questions',
      type: 'get',
      data: {sort: this.value}
    });
  });
});

$(document).on('turbolinks:load', function() {
  $('.btn-edit-subject').on('click', function(){
    var parent = $(this).closest('.collection-item').attr('class').slice(20);
    $('.' + parent + ' ' + '.edit-subject').css('display', 'block');
  })
});
