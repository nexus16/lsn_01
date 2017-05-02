$(document).on('turbolinks:load', function(){
  $('.tag-autocomplete-search').autocomplete({
    source: '/tags',
    minLength: 1,
    appendTo: '.result'
  });

  var data = [];

  $('.tag-list').children().each(function(){
   var tag_item = $(this).find('span').text();
    data.push(tag_item);
  });

  $('.tag-autocomplete-search').keyup(function (e) {
    var key = e.which;
    if(key == 188){
      var item = $('.tag-autocomplete-search').val();
      data.push(item.slice(0, -1));
      $('.tag-autocomplete-search').val('');
      $('.tag-list').append('<div class="chip"><span>'+item.slice(0, -1)+'</span><i class="close material-icons">close</i></div>');
    }
  });

  $(document).on('click', '.ui-menu-item', function(ev){
    ev.preventDefault();
    var item1 = $(this).find('div').text();
    data.push(item1);
    $('.tag-autocomplete-search').val('');
    $('.tag-list').append('<div class="chip"><span>'+item1+'</span><i class="close material-icons">close</i></div>');
  });

  $(document).on('click', '.close.material-icons', function(e){
    e.preventDefault();
    var item_delete = $(this).closest('div').find('span').text();
    data.pop(item_delete);
  })


  $('.form-new-question').submit(function() {
    $('.tag-list').val(data);
  });

});
