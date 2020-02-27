class NewslettersController < ApplicationController
  before_action :is_admin_or_editor?

  def index
    @newsletters = Newsletter.all
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  def new
    @newsletter = Newsletter.new
    @newsletter.title = "Revue de presse du #{Time.now.strftime("%d/%m/%Y")}"
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def create
    newsletter = Newsletter.new(newsletter_params)
    newsletter.user = current_user
    newsletter.status = 'draft'
    newsletter.newsletter_type = 'revue de presse'
    newsletter.save
    add_articles_to_newsletter(newsletter)
    redirect_to newsletters_path
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.status == "draft" && newsletter_params[:status] == "published"
      NewsletterMailer.with(newsletter: @newsletter).daily.deliver_now
    end
    @newsletter.update!(newsletter_params)
    redirect_to newsletters_path
  end

  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy
    redirect_to newsletters_path
  end

  private

  def add_articles_to_newsletter(newsletter)
    articles = Article.where(press_review_date: newsletter.press_review_date, status: 'published')
    newsletter.articles = articles
  end

  def is_admin_or_editor?
    if current_user.role == 'admin' || current_user.role == 'editor'
    else
      redirect_to root_path
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:title, :status, :press_review_date, :body)
  end
end
