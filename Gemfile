source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'mysql'
gem "authlogic"
gem "declarative_authorization"
# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'
gem "jquery-rails"
gem 'formtastic', '~> 1.1.0'

group :development do
  # To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
  gem 'ruby-debug'
  # gem 'ruby-debug19'
end

group :test, :cucumber do
  gem 'autotest'
  gem 'autotest-growl'
  gem 'autotest-fsevent'

  gem 'webrat'
  gem 'capybara', "0.3.9" # TODO capybara is held below 0.4.0 because of an error

  gem "shoulda"

  gem "rr"
  # gem "rspec-rr", :git => "git://github.com/josephwilk/rspec-rr.git", :branch => "rspec2" # installed as plugin

  gem "pickle"
  gem "factory_girl"
  gem "faker"
  gem "fakeweb"
  gem "timecop"

  gem "akephalos"
  #gem "culerity"
  #gem "celerity", :require => nil

  gem "launchy"
  gem "database_cleaner"

  gem "minitest" # we are still on 1.8.7
  gem "rspec", ">= 2"
  gem "rspec-rails", ">= 2"
  gem "cucumber"
  gem "cucumber-rails"
end

