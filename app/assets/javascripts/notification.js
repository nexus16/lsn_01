$(document).on('turbolinks:load',function(){
  $('.click-to-seen').on('click',function(e){
    var id = $(this).attr('data');
    $.ajax({
      type: "PUT",
      url: "/notifications/" + id,
      data: {notification: {seen: true}},
    });
  });
});

$(document).on('turbolinks:load',function(){
  $('.notification').on('click',function(){
    $('.notification-list').css('display','block');
  })
});

$(document).on('turbolinks:load',function(){
  $(document).mouseup(function (e){
    var container = $(".notification-list");
    if (!container.is(e.target) && container.has(e.target).length === 0){
      container.hide();
    }
  });
});
