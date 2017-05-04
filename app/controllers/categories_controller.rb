class CategoriesController < ApplicationController
  def index
    subjects = Category.list_objects params[:object]
    @questions = []
    subjects.each do |subject|
      (@questions << subject.questions).flatten!
    end
    @supports_sidebar = Supports::Sidebar.new subjects
  end

  def show
    category = Category.find_by id: params[:id]
    redirect_to root_path unless category
    @support = Supports::CategorySupport.new category
    @supports_sidebar = Supports::Sidebar.new [category]
    if category.root?
      respond_to do |format|
        format.html
        format.json{render json: @support.category_child}
      end
    end
  end
end
