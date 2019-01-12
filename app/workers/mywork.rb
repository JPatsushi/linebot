# require 'sidekiq'

# Sidekiq.configure_client do |config|
#   config.redis = { db: 1 }
# end

# Sidekiq.configure_server do |config|
#   config.redis = { db: 1 }
# end

class Ourworker
  include Sidekiq::Worker
  sidekiq_options retry: 0

  def perform(complexity)
    case complexity
      when 'super_hard' 
        # puts "Charing a credit card..."
        # raise "Woops stuff got bad"
        sleep 20
        puts 'Really took quite a bit of effort'
      when 'hard'
        sleep 10
        puts 'That was a bit of work'
      else
        sleep 1
        puts "That wasn't a lot of effort"
      end   
  end
end