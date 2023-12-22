class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # chatroom_channelからのストリーミングを開始する
    stream_from "chatroom_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # クライアントがメッセージ送信に使うメソッド
  def talk(data)
    # クライアントからのデータをもとにmessageモデルを組み立てる（現在日時を使用）
    message = Message.new
    message.published = Time.now
    message.sender = data['sender']
    message.content = data['content']
    debugger
    # Messageモデルをレンダリングしてchatroom_channelへブロードキャストする
    ActionCable.server.broadcast 'chatroom_channel',
      {message: render_message(message)}
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message',
      locals: { message: message })
  end
end
