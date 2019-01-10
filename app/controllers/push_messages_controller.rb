require 'line/bot'
class PushMessagesController < ApplicationController
  before_action :authenticate_user!

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
      config.channel_secret = '846a3b405ea4207f3906d04dcddf9804'
      config.channel_token = 'G4VJA8bWIrkK20HSL0qqgOn/+nULIQzZkaqzX+WR0K+Y3lF+6tsGaRc3cy7JcPENj6Vp6F0QAaJ0qDlhR4omVNCYd2I/9DNqajmwmysBYiFSyBZC1qEyo2Wxx1ZZ60t1U5e1zOo59vSIWMLYT2hxhwdB04t89/1O/w1cDnyilFU='
    }
  end
end