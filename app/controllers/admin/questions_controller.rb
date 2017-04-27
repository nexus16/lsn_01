class Admin::QuestionsController < Admin::AdminController
  def index
    @questions = Question.order_vote_questions.paginate(page: params[:page],
      per_page: Settings.per_page)
    if params[:sort]
      service = QuestionSortByTimeService.new params[:sort], params[:page]
      @questions = service.perform
      respond_to do |format|
        format.js
      end
    end
  end
end
