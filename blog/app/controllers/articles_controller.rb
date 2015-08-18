class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret",
  except: [:index, :show]

  before_action :all_articles, only: [:index, :create]
  respond_to :html, :js

# in order to play with AJAX
  # def index
  #   @articles = Article.all
  # end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      # render plain: params[:article].inspect
      redirect_to @article
    else
      render 'new'
      # redirect_to :back
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def all_articles
    @articles = Article.all
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
