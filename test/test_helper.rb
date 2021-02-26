# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

$:.unshift File.dirname(__FILE__)

require "dummy_app/config/environment"
require "rails/test_help"
require 'minitest/autorun'

$:.unshift File.expand_path('../support', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'mocha/minitest'
