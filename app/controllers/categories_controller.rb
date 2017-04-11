class CategoriesController < ApplicationController

  def show
    category = Category.find_by id: params[:id]
    redirect_to root_path unless category
    @support = Supports::CategorySupport.new category
    if category.root?
      respond_to do |format|
        format.html
        format.json{render json: @support.category_child}
      end
    else
      @supports = Supports::Home.new
    end
  end
end
