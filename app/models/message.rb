class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self } # コミット後に実行する処理を遅延実行
end
