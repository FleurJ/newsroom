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
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def create
    newsletter = Newsletter.new(newsletter_params)
    newsletter.user = current_user
    newsletter.status = 'draft'
    newsletter.save
    redirect_to newsletters_path
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    @newsletter.update!(newsletter_params)
    redirect_to newsletters_path
  end

  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy
    redirect_to newsletters_path
  end

  private

  def is_admin_or_editor?
    if current_user.role == 'admin' || current_user.role == 'editor'
    else
      redirect_to root_path
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:title, :status, :newsletter_type)
  end
end
