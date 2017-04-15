class Admin::ReportsController < Admin::AdminController
  def index
    @questions = Question.joins(:reports).group("questions.id")
  end
end
