class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, except: [:index, :create, :new]

  def index
    @support_category_admin = Supports::CategoryAdmin.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_success"
    else
      flash[:danger] = t "create_false"
    end
    redirect_to :back
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
    else
      flash[:danger] = t "update_false"
    end
    redirect_to :back
  end

  def destroy
    if @category.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_false"
    end
    redirect_to :back
  end

  private
  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def find_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:error] = t "not_found"
      redirect_to :back
    end
  end
end
