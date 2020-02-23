class CommentsController < ApplicationController
  before_action :find_article, only: [:new, :create, :destroy]
  before_action :check_comment, only: [:destroy, :edit, :update]
  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to article_path(@article)
  end

  def edit
  end

  def update
    if authorised_user
      @comment.update!(comment_params)
      redirect_to article_path(@comment.article.id)
    elsif @comment.user == current_user
      @comment.update!(comment_params)
      redirect_to article_path(@comment.article.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    if authorised_user
      @comment.destroy
      redirect_to article_path(@article)
    elsif @comment.user == current_user
      @comment.destroy
      redirect_to article_path(@article)
    else
      redirect_to root_path
    end
  end

  private

  def authorised_user
    return true if current_user.role == 'admin'
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def check_comment
    @comment = Comment.find(params[:id])
  end
end
