module Admins
  class CategoriesController < BaseController
    def index
      @categories = Category.all
      @rewards_count = @categories.joins(:rewards).group('category_rewards.category_id').count.to_h
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
        redirect_to admins_categories_path, notice: "Category #{category.title} was successfully created."
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
      authorize category
      category.destroy
      redirect_to admins_categories_path, notice: "Categoty #{@category.title} was deleted."
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
