module Admins
  class CategoriesController < BaseController
    def index
      @categories = Category.all
    end

    def show
      category
    end

    def new
      @category = Category.new
    end

    def edit
      category
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admins_category_path(@category), notice: "Category #{category.title} was successfully created."
      else
        render :new
      end
    end

    def update
      if category.update(category_params)
        redirect_to admins_category_path(category), notice: "Category #{category.title} was updated"
      else
        render :edit
      end
    end

    def destroy
      if category.rewards.any?
        flash[:alert] = 'Categoty can not be deleted. There are rewards in this category.'
        redirect_back fallback_location: admins_categories_path
      else
        @category.destroy
        redirect_to admins_categories_path, notice: "Categoty #{@category.title} was deleted."
      end
    end

    private

    def category
      @category ||= Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
