class TagsController < ApplicationController
  def index
    @tags = Tag.where(status: "published")
  end

  def create

  end
end
