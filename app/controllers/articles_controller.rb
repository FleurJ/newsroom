class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy]

  def new
    @article = Article.new
    @tags = Tag.all
  end

  def create
    @article = Article.new(article_params)
    set_user_status
    process_belga_file
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

  def article_params
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :teaser, tag_ids: [])
  end

  def check_article
    @article = Article.find(params[:id])
  end

  def process_belga_file
    @article = BelgaScrapping.new.scrap_article(params[:article][:belga_file].tempfile, @article)
  end

  def set_user_status
    @article.user = current_user
    @article.status = 'draft'
  end
end
