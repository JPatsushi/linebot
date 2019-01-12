class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(text)
    # Do something later
    Ourworker.perform_async(text)
    # puts "ジョブが実行されたよ！＼(^o^)／"
  end
  
  def push_job
    text = "jobです"
    Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
  end

  # 傳送訊息到 line
  def push_to_line(channel_id, text)
    return nil if channel_id.nil? or text.nil?
    
    # 設定回覆訊息
    message = {
      type: 'text',
      text: text
    } 

    # 傳送訊息
    line.push_message(channel_id, message)
  end

  # Line Bot API 物件初始化
  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    }
  end




end
