if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://redistogo:f9b50dae0633dc8774a2e8ead9feef81@barb.redistogo.com:9531/" }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://redistogo:f9b50dae0633dc8774a2e8ead9feef81@barb.redistogo.com:9531/" }
  end
else
  Sidekiq.configure_client do |config|
    config.redis = { db: 1 }
  end
  
  Sidekiq.configure_server do |config|
    config.redis = { db: 1 }
  end
end