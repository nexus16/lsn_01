class Supports::Home
  def initialize current_user
    @current_user = current_user
  end

  def list_question
    Question.order_DESC
  end

  def list_class
    Category.roots
  end

  def list_object
    Category.leaves.map(&:name).uniq
  end

  def notifications
    @current_user.notifications.order_new_notifications
  end
end
