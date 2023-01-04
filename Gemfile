# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'
gem 'cssbundling-rails'
gem 'devise'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem 'bootsnap', require: false
gem 'sassc-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rails-erd'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'shoulda-matchers', '~> 5.2'
end
# gem "pundit"
gem 'htmlbeautifier', '~> 1.4', '>= 1.4.2'
gem 'pundit', '~> 2.2'
gem 'rubocop', '~> 1.40'
gem 'rubocop-rails', '~> 2.17', '>= 2.17.3'
gem 'rubocop-rspec', '~> 2.16'
gem 'solargraph', '~> 0.47.2'

gem 'importmap-rails', '~> 1.1'
gem 'jsonapi-serializer'
