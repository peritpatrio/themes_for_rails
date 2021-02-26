# frozen_string_literal: true

require File.expand_path("test/test_helper.rb")

class ThemesForRailsTest < ::ActiveSupport::TestCase
  test 'should change the base directory' do
    ThemesForRails.config do |config|
      config.base_dir = 'empty_themes'
    end

    assert_equal [], ThemesForRails.available_theme_names
  end

  test 'should change the directory to views' do
    ThemesForRails.config do |config|
      config.themes_dir = ':root/another_themes'
    end

    assert_equal ['another_default'], ThemesForRails.available_theme_names
  end

  teardown do
    ThemesForRails.config.clear
  end
end
