class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(text)
    # Do something later
    Ourworker.perform_async(text)
    # puts "ジョブが実行されたよ！＼(^o^)／"
  end
end
