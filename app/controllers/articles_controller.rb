class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
    @tags = Tag.all
  end

  def create
    articles_generation_params.each do |item|
      Article.create(item.merge(user: current_user, status: 'draft'))
    end
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
      date_start = params[:query]
    else
      date_start = DateTime.now.strftime("%Y-%m-%d")
    end
    articles = Article.all
    @articles = []
    articles.each do |a|
      if a.created_at.strftime("%Y-%m-%d") == date_start
        @articles << a
      end
    end
  end

  private

  def check_article
    @article = Article.find(params[:id])
  end

  def belga_file
    params[:article][:belga_file]
  end

  def gopress_file
    params[:article][:gopress_file]
  end

  def article_params
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :teaser, tag_ids: [])
  end

  def belga_article_params
    BelgaScrapping.new.scrap_article(belga_file.tempfile, article_params)
  end

  def gopress_article_params
    GopressScrapping.new.scrap_articles(gopress_file.tempfile, article_params)
  end

  def articles_generation_params
    return gopress_article_params if gopress_file.present?
    return [belga_article_params] if belga_file.present?
    return [article_params]
  end
end
