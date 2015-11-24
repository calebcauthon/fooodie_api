class RecipesController < ApplicationController
  respond_to :html, :json
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :set_recipe, only: [:update, :destroy]

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

  def update
    @recipe.update(recipe_params)
    render :json => @recipe
  end

  def destroy
    @recipe.destroy
    render :json => @recipe
  end

  private
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :body)
    end

end
