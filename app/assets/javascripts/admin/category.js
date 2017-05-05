$(document).on('click', '.btn-create-category', function(e){
  e.preventDefault();
  $.ajax({
    type: 'GET',
    url: '/admin/categories/new'
  });
});

$(document).on('click', '.btn-edit-category', function(e){
  e.preventDefault();
  var id = $(this).attr('data');
  $.ajax({
    type: 'GET',
    url: '/admin/categories/' + id + '/edit'
  });
});
