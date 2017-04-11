class CategoriesController < ApplicationController

  def index
    objects = Category.list_objects params[:object]
    @questions = []
    objects.each do |object|
      (@questions << object.questions).flatten!
    end
  end

  def show
    category = Category.find_by id: params[:id]
    redirect_to root_path unless category
    @support = Supports::CategorySupport.new category
    if category.root?
      respond_to do |format|
        format.html
        format.json{render json: @support.category_child}
      end
    end
  end
end
