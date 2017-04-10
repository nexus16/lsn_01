class CategoriesController < ApplicationController
  before_action :find_category, only: :show

  def show
    @support = Supports::Category.new category
    if category.root?
      respond_to do |format|
        format.html
        format.json{render json: @support.category_child}
      end
    else
      @supports = Supports::Home.new
    end
  end

  private
  def find_category
    category = Category.find_by id: params[:id]
    redirect_to root_path unless category
  end
end
