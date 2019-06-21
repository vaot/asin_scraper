class ScraperExpressionsController < ApplicationController
  before_action :load_expression, only: [:destroy]

  def index
    @scraper_expressions = ScraperExpression.all
  end

  def new
    @scraper_expression = ScraperExpression.new
  end

  def create
    scraper_expression = ScraperExpression.create(scraper_expression_params)
    redirect_to scraper_expressions_path
  end

  def destroy
    @scraper_expression.destroy
    redirect_to scraper_expressions_path
  end

  private

  def scraper_expression_params
    params.require(:scraper_expression).permit(:key, :expression)
  end

  def load_expression
    @scraper_expression = ScraperExpression.find(params[:id])
  end
end
