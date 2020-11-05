class CommentChannel < ApplicationCable::Channel
  def subscribed 
    stream_from "comment_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

# channel file は指定したものをリアルタイムで更新させる際に使われるActionCableの機能。
# subscribedに記載したchannnelと指定したコントローラ内のchannelの記述を合わせる必要がある。