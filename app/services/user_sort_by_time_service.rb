class UserSortByTimeService
  def initialize sort, subjects_id = nil
    @sort = sort
    @subjects_id = subjects_id
  end

  def perform
    case @sort
    when "general"
      @users = User.order_most_voted
    when "for-week"
      begin_date = 1.week.ago.beginning_of_week
      end_date = 1.week.ago.end_of_week
      sort_by_time begin_date, end_date
    when "for-month"
      begin_date = 1.month.ago.beginning_of_month
      end_date = 1.month.ago.end_of_month
      sort_by_time begin_date, end_date
    end
  end

  private
  def sort_by_time begin_date, end_date
    if @subjects_id
      answers = Answer.answers_by_time begin_date, end_date
      answers_id = answers.map{|answer| answer[:id] if
        @subjects_id.include?(answer.question.category_id)}.compact
    else
      answers_id = Answer.answers_id_by_time begin_date, end_date
    end
    @users = list_users answers_id, begin_date, end_date
    @users = @users.sort_by{|user| user.vote_count}.reverse!
  end

  def list_users answers_id, begin_date, end_date
    vote_count = 0
    users = User.joins(:answers).where("answers.id IN(?)", answers_id).uniq
    users.each do |user|
      user.answers.where("answers.id IN(?)", answers_id).each do |answer|
        vote_count += answer.votes.where("votes.created_at
          BETWEEN ? AND ?", begin_date, end_date)
          .sum{|v| Vote.vote_types[v.vote_type]}
      end
      user.vote_count = vote_count
      vote_count = 0
    end
  end
end
