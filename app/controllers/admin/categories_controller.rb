class Admin::CategoriesController < Admin::BaseController

  
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], success: 'Category created!'
    else
      redirect_to new_admin_category_path, danger: 'Category name is mandatory!'
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
       
    redirect_to [:admin, :categories], success: 'Category deleted!'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
