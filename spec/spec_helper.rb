require 'rubygems'
require 'bundler'

Bundler.require(:default, :test)

require 'simplecov'
require 'simplecov-html'

SimpleCov.start do
  add_filter 'spec'
  add_filter 'public'
end
SimpleCov.coverage_dir(ENV['COVERAGE_DIR'])

require 'rack'

require_relative '../lib/phonebook'

#require 'rspec/autorun'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
