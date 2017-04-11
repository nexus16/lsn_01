class TagsController < ApplicationController
  def index
    @tags = Tag.search params[:term]
    render json: @tags.map{|tag| tag.name}
  end

  def show
    tag = Tag.find_by name: params[:id]
    if tag
      @questions = Question.tagged_with tag.name
    else
      flash[:danger] = t "no_tag"
      redirect_to root_path
    end
  end
end
