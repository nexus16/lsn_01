class SearchesController < ApplicationController
  def index
    @tags =
      if params[:query].present?
        Tag.search params[:query], operator: "or", suggest: true,
        match: :word_start
      else
        Array.new
      end
    @questions =
      if params[:query].present?
        Question.search params[:query], operator: "or",
          fields: [:title, :content], highlight: true, suggest: true,
          match: :word_start, page: params[:page], per_page: Settings.per_page
      else
        Array.new
      end
  end
end
