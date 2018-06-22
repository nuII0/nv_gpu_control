source "https://rubygems.org"

gem 'logging'

group :development do
  gem 'pry'
  gem 'pry-doc'
end

unless %w(jruby rbx).include? RUBY_ENGINE
  group :test do
    gem 'simplecov'
    gem 'rspec'
  end

  group :development do
    gem 'redcarpet'
    gem 'yard'
    gem 'pry-stack_explorer'
  end
end
