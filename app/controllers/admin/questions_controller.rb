class Admin::QuestionsController < Admin::AdminController
  require "will_paginate/array"

  def index
    @questions = Question.order_vote_questions.paginate(page: params[:page],
      per_page: Settings.per_page)
    if params[:sort]
      service = QuestionSortByTimeService.new params[:sort]
      @questions = service.perform
      @questions = @questions.paginate page: params[:page],
        per_page: Settings.per_page
      unless params[:page]
        respond_to do |format|
          format.js
        end
      end
    end
  end
end
