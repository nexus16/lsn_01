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
