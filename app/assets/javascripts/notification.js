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

$(document).on('turbolinks:load',function(){
  (function() {
    var current_user_id = $('.notification').attr('data-current-user');
    var noti_count = parseInt($('.notification span').text());

    App.notifications = App.cable.subscriptions.create(
      {channel: 'NotificationsChannel'},
      {
        received: function(data) {
          console.log(data);
          noti_count++;
          $('.notification span').text(noti_count);
          $('.notification-list').prepend(
            function(){
              if(data.type == 1){
                if(data.user_owner_question == current_user_id){
                  return '<li class="collection-item click-to-seen seen-false" ><p><a href="/questions/'+data.question_id+ ' "><strong> '+data.user_name_noti+'</strong> replied in your question</a> <strong>'+data.title_question+'</strong></p></li>';
                }
                else{
                  return '<li class="collection-item click-to-seen seen-false" ><p><a href="/questions/'+data.question_id+ ' "><strong> '+data.user_name_noti+'</strong> also replied in question you following</a> <strong>'+data.title_question+'</strong></p></li>';
                }
              }
              else if(data.type == 2){
                if(data.user_owner_question == current_user_id){
                  return '<li class="collection-item click-to-seen seen-false" ><p><a href="/questions/'+data.question_id+ ' "><strong> '+data.user_name_noti+'</strong> voted in your question</a> <strong>'+data.title_question+'</strong></p></li>';
                }
                else{
                  return '<li class="collection-item click-to-seen seen-false" ><p><a href="/questions/'+data.question_id+ ' "><strong> '+data.user_name_noti+'</strong> votedin your answer</a> <strong>'+data.title_question+'</strong></p></li>';
                }
              }

            }
          )
        }
      }
    );
  }).call(this);
});


