class ArticlesController < ApplicationController
  before_action :check_article, only: [:edit, :update, :show, :destroy, :favorite]
  before_action :autodate, only: [:index]
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

  def favorites
    @articles = current_user.favorite_articles.map(&:article).sort_by(&:created_at).reverse!
  end

  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @article
    elsif type == "unfavorite"
      current_user.favorites.delete(@article)
    end
    redirect_back(fallback_location: "/")
  end

  def draft
    articles = Article.all.sort_by(&:created_at).reverse!
    @articles = []
    articles.each do |a|
      if current_user == a.user
        @articles << a if a.status == 'draft'
      end
    end
  end

  def delete_drafts
    drafts = Article.where(status: "draft", user: current_user)
    drafts.each do |item|
      item.destroy
    end
    redirect_to draft_path
  end

  def search
    @articles = Article
    return @articles = @articles.none unless params[:keywords].present?
    @articles = @articles.by_keywords(params[:keywords]) if params[:keywords].present?
    @articles = @articles.published_between(params[:start_date], params[:end_date]).published
  end

  def new
    @article = Article.new
    @tags = Tag.all
  end

  def create
    articles_generation_params.each do |item|
      a = Article.create(item.merge(user: current_user, status: 'draft'))
      if item[:article_type] == "presse"
        pub_date = adapt_publication_date_scrapping(item[:publication_date])
        a.publication_date = pub_date
        a.save
      end
    end
    redirect_to draft_path
  end

  def edit
    @tags = Tag.all
  end

  def update
    if authorised_user
      @article.update!(article_params)
      redirect_to article_path(@article)
    elsif @article.user == current_user
      @article.update!(article_params)
      redirect_to article_path(@article)
    else
      redirect_to root_path
    end
  end

  def destroy
    if authorised_user
      @article.destroy
      redirect_to articles_path
    elsif @article.user == current_user
      @article.update!(article_params)
      redirect_to article_path(@article)
    else
      redirect_to root_path
    end
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
    articles = Article.all.sort
    @articles = []
    articles.each do |a|
    @articles << a if a.press_review_date == date_start && a.status == 'published'
    end
  end

  private

  def authorised_user
    return true if current_user.role == 'admin' || current_user.role == 'editor'
  end

  def adapt_publication_date_scrapping(item)
    my_hash = {
      'jan' => '01',
      'fév' => '02',
      'mar' => '03',
      'avr' => '04',
      'mai' => '05',
      'jui' => '06',
      'juil'=> '07',
      'aoû' => '08',
      'sep' => '09',
      'oct' => '10',
      'nov' => '11',
      'dec' => '12'
    }

    x = item.gsub('.', '')
    x = x.split(' ')
    x.shift
    day = x[0]
    month = my_hash[x[1]]
    year = x[2]
    publication_date = "#{year}-#{month}-#{day}".to_date

    return publication_date
  end

  def autodate
    params[:query] = DateTime.now.strftime("%Y-%m-%d") if params[:query].nil?
  end

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
    params.require(:article).permit(:title, :publication_date, :source_name, :source_url, :body, :status, :press_review_date, :teaser, :article_type, tag_ids: [])
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
