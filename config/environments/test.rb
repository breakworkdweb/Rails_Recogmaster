require 'active_support/core_ext/numeric/bytes'
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.host = "localhost:3000"
  # config.asset_host = "//"+config.host
  
  config.send_push_notifications = false

  config.logger = Logger.new(config.paths["log"].first, 1, 104857600)
  # config.log_level = :warn
  # config.cache_store = :null_store
  config.cache_store = :memory_store, { size: 256.megabytes }
  
  config.middleware.use RackSessionAccess::Middleware  

  config.eager_load = false

  config.assets.configure do |env|
    if ENV['ASSETS_IN_MEMORY']
      env.cache = ActiveSupport::Cache.lookup_store(:memory_store)
    end
  end

  if ENV['PRECOMPILE_TEST_ASSETS']
    puts "Precompiling assets for tests"
    config.assets.prefix = "/capybara_test_assets"
    config.assets.enabled = false
    config.assets.digest = false
    config.assets.cache_store = :null_store
    config.sass.cache = false
    # config.assets.compress = true
    # config.assets.compile = false
  end
end
