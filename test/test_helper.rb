require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/app/channels/'
  add_filter '/app/jobs/'
  add_filter '/app/mailers/'
  add_filter '/app/views/'
end

# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
