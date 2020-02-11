class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy]
  FRENCH_MONTHS = {
    "01": "janvier",
    "02": "février",
    "03": "mars",
    "04": "avril",
    "05": "mai",
    "06": "juin",
    "07": "juillet",
    "08": "août",
    "09": "septembre",
    "10": "octobre",
    "11": "novembre",
    "12": "décembre"
  }

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
      date_start = Date.parse params[:query]
      @date = date_start.strftime("%d") + " " + FRENCH_MONTHS[date_start.strftime("%m").to_sym] + " " + date_start.strftime("%Y")
    else
      date_start = DateTime.now.strftime("%Y-%m-%d")
      @date = DateTime.now.strftime("%d") + " " + FRENCH_MONTHS[DateTime.now.strftime("%m").to_sym] + " " + DateTime.now.strftime("%Y")
    end
    articles = Article.all
    @articles = []
    articles.each do |a|
      if a.press_review_date == date_start
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
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :press_review_date  ,:teaser, tag_ids: [])
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
