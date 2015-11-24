class RecipesController < ApplicationController
  respond_to :html, :json

  def index
    @recipes = Recipe.all
    render :json => @recipes.to_json(:include => :user)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.save
    render :json => @recipe
  end

  def show
    render :json => Recipe.find(params[:id])
  end
  
  private

    def recipe_params
      params.require(:recipe).permit(:title, :body)
    end

end
