class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    set_user_status
    process_belga_file
    @article.save!
    redirect_to articles_path
  end

  def edit
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
  end

  def index
    @articles = Article.all
  end

  private

  def article_params
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :teaser)
  end

  def check_article
    @article = Article.find(params[:id])
  end

  def process_belga_file
    if @article.file.empty?
      scrap_title(Article.belga_file)
      scrap_body(Article.belga_file)
      fill_fields
    end
  end

  def set_user_status
    @article.user = current_user
    @article.status = 'draft'
  end

end
