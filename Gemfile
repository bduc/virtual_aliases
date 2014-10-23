source 'https://rubygems.org'

gemspec

gem 'pg', :platform => :ruby
gem "activerecord-jdbcpostgresql-adapter", ">= 1.3.1", :platform => :jruby

gem "activerecord", ENV["ACTIVE_RECORD_VERSION"] if ENV["ACTIVE_RECORD_VERSION"]
gem "activerecord", :github => "rails", :branch => ENV["ACTIVE_RECORD_BRANCH"] if ENV["ACTIVE_RECORD_BRANCH"]

if ENV["TRAVIS"]
  gem 'coveralls', :require => false, :platform => :mri_20
end
