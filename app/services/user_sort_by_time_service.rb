class UserSortByTimeService
  def initialize sort, params_page
    @sort = sort
    @params_page = params_page
  end

  def perform
    case @sort
    when "general"
      @users = User.order_most_voted.paginate(page: @params_page,
        per_page: Settings.per_page)
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
    answers = Answer.answers_by_time begin_date, end_date
    @users = list_users answers, begin_date, end_date
    @users = @users.sort_by{|user| user.vote_count}.reverse!
    @users =
      WillPaginate::Collection.create(1, 10, @users.length) do |pager|
        pager.replace @users
      end
  end

  def list_users answers, begin_date, end_date
    vote_count = 0
    users = User.joins(:answers).where("answers.id IN(?)", answers).uniq
    users.each do |user|
      user.answers.where("answers.id IN(?)", answers).each do |answer|
        vote_count += answer.votes.where("votes.created_at
          BETWEEN ? AND ?", begin_date, end_date)
          .sum{|v| Vote.vote_types[v.vote_type]}
      end
      user.vote_count = vote_count
      vote_count = 0
    end
  end
end
