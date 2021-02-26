# frozen_string_literal: true

require File.expand_path("test/test_helper.rb")

class ViewHelpersTest < ::ActionDispatch::IntegrationTest
  include ::ThemesForRails::ActionView
  include ::ActionView::Helpers::AssetTagHelper
  include ::ERB::Util
  include ::ActionView::Helpers::TagHelper
  include ::ActionView::Helpers::FormTagHelper

  def theme_name
    'default'
  end

  def config
    @config ||= stub(
      perform_caching: false,
      asset_path: '/assets',
      asset_host: '',
      default_asset_host_protocol: 'http'
    )
  end
end

module ThemesForRails
  class CommonViewHelpersTest < ViewHelpersTest
    test "provide path helpers for a given theme name" do
      assert_equal "/themes/sometheme/stylesheets/style.css", theme_stylesheet_path('style', "sometheme")
      assert_equal "/themes/sometheme/javascripts/app.js", theme_javascript_path('app', "sometheme")
      assert_equal "/themes/sometheme/images/logo.png", theme_image_path('logo.png', "sometheme")
    end

    test "provide path helpers for a given theme name with dots" do
      assert_equal "/themes/some.theme/stylesheets/style.css", theme_stylesheet_path('style', "some.theme")
      assert_equal "/themes/some.theme/javascripts/app.js", theme_javascript_path('app', "some.theme")
      assert_equal "/themes/some.theme/images/logo.png", theme_image_path('logo.png', "some.theme")
    end

    test 'delegate to stylesheet_link_tag' do
      assert_match(/media=.screen/, theme_stylesheet_link_tag('cuac.css'))
    end

    test 'delegate options (lazy testing, I know)' do
      assert_match(/media=.print/, theme_stylesheet_link_tag('cuac.css', :media => 'print'))
    end

    test 'delegate options in image_tag' do
      assert_match(/width=.40/, theme_image_tag('image.css', :size => '40x50'))
    end

    test 'delegate options in image_submit_tag' do
      assert_match(/class=.search_button/, theme_image_submit_tag('image.png', :class => 'search_button'))
    end
  end
end
