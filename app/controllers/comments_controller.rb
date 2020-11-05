class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment.content, time: @comment.created_at , nickname: @comment.user.nickname
      # 推察
      # ActionCable.server.broadcast 'comment_channel' -> ActionCableを使用する宣言みたいな記述。
      # それ以降のキーバリューはviewなどで使用したい箇所・・・？
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:content).merge(
      user_id: current_user.id, item_id: params[:item_id])
  end
end
