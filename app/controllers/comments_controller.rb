class CommentsController < ApplicationController
  def create
    @comments = @item.comments.includes(:user)
    @comment = Comments.new
  end
end
