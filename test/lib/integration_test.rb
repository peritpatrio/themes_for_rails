# frozen_string_literal: true

require File.expand_path("test/test_helper.rb")

class ThemesForRailsIntegrationTest < ::ActionDispatch::IntegrationTest
  test "should work with Rails 5 default configuration" do
    asset_path = "/themes/default/stylesheets/style.css"
    get asset_path
    assert_equal 200, status
    assert_equal asset_path, path
  end
end
