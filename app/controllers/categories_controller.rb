class CategoriesController < ApplicationController
  def show
    @questions = Category.find_by(id: params[:id]).questions
    @supports = Supports::Home.new
    @categories = Category.find_by(id: params[:id]).descendants
    respond_to do |format|
      format.html
      format.json{render json: @categories}
    end
  end
end
