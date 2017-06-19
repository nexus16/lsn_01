class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification
    if notification.answer
      user_name_noti = notification.answer.user.username
      type = 1
    elsif notification.vote
      user_name_noti = notification.vote.user.username
      type = 2
    end
    ActionCable.server.broadcast "notification_channel_#{notification.user_id}",
      user_name_noti: user_name_noti, question_id: notification.question_id,
      type: type, user_owner_question: notification.question.user.id,
      title_question: notification.question.title
  end

end

