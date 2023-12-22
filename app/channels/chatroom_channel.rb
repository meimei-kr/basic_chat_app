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
    Message.create!(published: message.published, sender: message.sender, content: message.content)
  end
end
