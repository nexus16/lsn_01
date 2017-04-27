class QuestionSortByTimeService
  def initialize sort, params_page
    @sort = sort
    @params_page = params_page
  end

  def perform
    case @sort
    when "general"
      @questions = Question.order_vote_questions.paginate(page: @params_page,
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
    questions = Question.questions_by_time begin_date, end_date
    @questions = list_questions questions, begin_date, end_date
    @questions = @questions.sort_by{|question| question.vote_count}.reverse!
    @questions =
      WillPaginate::Collection.create(1, 10, @questions.length) do |pager|
        pager.replace @questions
      end
  end

  def list_questions questions, begin_date, end_date
    vote_count = 0
    questions.each do |question|
      vote_count += question.votes.where("votes.created_at
        BETWEEN ? AND ?", begin_date, end_date)
        .sum{|v| Vote.vote_types[v.vote_type]}
      question.vote_count = vote_count
      vote_count = 0
    end
  end
end
