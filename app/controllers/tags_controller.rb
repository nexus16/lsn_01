class TagsController < ApplicationController
  def index
    if params[:term]
      @tags = Tag.search_tag params[:term]
      render json: @tags.map{|tag| tag.name}
    else
      tag = Tag.list_tag params[:name]
      list_tag = tag.map{|t| t.name}
      @questions = Question.tagged_with list_tag
    end
  end

  def show
    tag = Tag.find_by id: params[:id]
    if tag
      @questions = Question.tagged_with tag.name
    else
      flash[:danger] = t "no_tag"
      redirect_to root_path
    end
  end
end
