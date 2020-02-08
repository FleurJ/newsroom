class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
    @tags = Tag.all
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.status = 'draft'
    @article.save!
    redirect_to articles_path
  end

  def edit
    @tags = Tag.all
  end

  def update
    @article.update!(article_params)
    redirect_to articles_path
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def show
    @tags = @article.tags
  end

  def index
    if params[:query].present?
      sql_query = " \
        articles.title @@ :query \
      "
      @articles = Article.where(sql_query, query: "%#{params[:query]}%")
    else
      @articles = Article.all
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :teaser, tag_ids: [])
  end

  def check_article
    @article = Article.find(params[:id])
  end
end
