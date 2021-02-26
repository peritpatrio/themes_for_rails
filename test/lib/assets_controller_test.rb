# frozen_string_literal: true

require File.expand_path("test/test_helper.rb")

module ThemesForRails
  class AssetsControllerTest < ::ActionController::TestCase
    tests ThemesForRails::AssetsController

    test "should respond to stylesheets" do
      assert @controller.respond_to?(:stylesheets)
    end

    test "should respond with the right stylesheet file when requested" do
      get 'stylesheets', params: { theme: 'default', asset: 'style.css'}
      assert_response :success
      assert_equal @response.content_type, 'text/css'
    end

    test "should not be success when the stylesheet file is not found" do
      get 'stylesheets', params: { theme: 'default', asset: 'oldstyle.css'}
      assert_response :missing
    end

    # javascripts
    test "should respond to javascripts" do
      assert @controller.respond_to?(:javascripts)
    end

    test "should respond with the right javascript file when requested" do
      get 'javascripts', params: { theme: 'default', asset: 'app.js'}
      assert_response :success
      assert_equal @response.content_type, 'text/javascript'
    end

    test "should respond with the right javascript file when requested (including multiple dot on the filename)" do
      get 'javascripts', params: { theme: 'default', asset: 'app.min.js'}
      assert_response :success
      assert_equal @response.content_type, 'text/javascript'
    end

    test "should not be success when the javascript file is not found" do
      get 'javascripts', params: { theme: 'default', asset: 'oldapp.js'}
      assert_response :missing
    end

    # images
    test "should respond to images" do
      assert @controller.respond_to?(:images)
    end

    test "should respond with the right image file when requested" do
      get 'images', params: { theme: 'default', asset: 'logo.png'}
      assert_response :success
      assert_equal  'image/png', @response.content_type
    end

    test "should not be success when the image file is not found" do
      get 'images', params: { theme: 'default', asset: 'i_am_not_here.jpg'}
      assert_response :missing
    end

    test "should respond with a nested asset" do
      get 'images', params: { theme: 'default', asset: 'nested/logo.png'}
      assert_response :success
      assert_equal 'image/png', @response.content_type
    end

    test "should respond with properly even when requesting an image inside the stylesheets folder" do
      get 'stylesheets', params: { theme: 'default', asset: 'images/logo.png'}
      assert_response :success
      assert_equal @response.content_type, 'image/png'
    end
  end
end
