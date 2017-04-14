class SearchesController < ApplicationController
  def index
    @questions =
      if params[:query].present?
        Question.search params[:query], operator: "or",
          fields: [:title, :content], highlight: true, suggest: true,
          page: params[:page], per_page: Settings.per_page
      else
        Array.new
      end
  end
end
