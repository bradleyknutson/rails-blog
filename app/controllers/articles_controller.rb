class ArticlesController < ApplicationController
  # before_action :require_user, only: [:index, :show]

  def index
    if params[:search]
      @articles = Article.search(params[:search]).records
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.includes(parent_comments: [:comments, :user]).find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to (@article)
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
