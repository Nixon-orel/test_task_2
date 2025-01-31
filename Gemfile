source "https://rubygems.org"

ruby "3.2.1"

gem "rails", "~> 7.2.2"
gem "pg"

gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "strong_migrations"
gem "active_interaction", "~> 5.4"
gem "figaro"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop"
  gem "pry-byebug"
  gem "pry-rails"
end

group :test do
  gem "rspec"
  gem "rspec-rails"
  gem "database_cleaner-active_record"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "rubocop-rails-omakase", require: false
end
