class TagsController < ApplicationController
  before_action :find_tag, only: [:update, :edit, :destroy, :show]

  def show
    @articles = []
    articles = @tag.articles.sort_by(&:created_at).reverse!
    articles.each do |a|
      @articles << a if a.status == 'published'
    end
  end

  def index
    if authorised_user
      @tags = Tag.all.sort_by(&:name)
    else
      @tags = Tag.where(status: "published")
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    if authorised_user
      @tag = Tag.new(tag_params)
      @tag.save
    end
    redirect_to tags_path
  end

  def edit
  end

  def update
    @tag.update(tag_params) if authorised_user
    redirect_to tags_path
  end

  def destroy
    @tag.destroy if authorised_user
    redirect_to tags_path
  end

  private

  def authorised_user
    return true unless current_user.role == "user"
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :status)
  end
end
