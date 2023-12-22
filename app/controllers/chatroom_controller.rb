class ChatroomController < ApplicationController
  def show
    # 全レコードをpublishedフィールドの降順で取得する
    @messages = Message.order(published: :desc)
  end
end
