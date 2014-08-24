source 'https://rubygems.org'

gem 'bootstrap-sass',                  '~> 3.0.2.0'
gem 'bootstrap3-datetimepicker-rails', '~> 3.0.0'
gem 'coffee-rails',                    '~> 4.0.0'
gem 'devise'
gem 'draper'
gem 'font-awesome-sass'
gem 'jbuilder',                        '~> 2.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'momentjs-rails',                  '~> 2.5.0'
gem 'pg'
gem 'rails',                           '~> 4.1.1'
gem 'sass-rails',                      '~> 4.0.3'
gem 'turbolinks'
gem 'uglifier',                        '>= 1.3.0'
gem 'foreman'
gem 'ruby-prof'

group :production do
  gem 'unicorn'
end

group :development do
  gem 'mina'
  gem 'mina-nginx', require: false
  gem 'spring'
  gem 'spring-commands-cucumber'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'byebug'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'test_after_commit'
  gem 'timecop'
end

ruby "2.1.2"
