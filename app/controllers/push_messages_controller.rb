require 'line/bot'
class PushMessagesController < ApplicationController
  before_action :authenticate_user!

  def example
    # Ourworker.perform_async('easy')
    GuestsCleanupJob.set(wait: 20.seconds).perform_later('line')
    redirect_to new_push_message_path
  end

  # GET /push_messages/new
  def new
  end

  # POST /push_messages
  def create
    text = params[:text]
    Channel.all.each do |channel|
      push_to_line(channel.channel_id, text)
    end
    redirect_to '/push_messages/new'
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