# encoding: utf-8
require File.expand_path("test/test_helper.rb")

class MyController < ActionController::Base
  def hello
    render plain: "Just a test"
  end
end

class CustomThemeController < ActionController::Base
  def hello
    render plain: "Just a test"
  end

  def theme_selector
    'custom'
  end
end

class PrivateCustomThemeController < ActionController::Base
  def hello
    render plain: "Just a test"
  end

  private

  def private_theme_selector
    'private_custom'
  end
end

class ActionMailerInclusionTest < ::ActiveSupport::TestCase
  test "include the ActionController module" do
    assert ActionMailer::Base.included_modules.include?(ThemesForRails::ActionController)
  end
end

class ActionControllerInclusionTest < ::ActiveSupport::TestCase
  test "include the ActionController module" do
    assert ActionController::Base.included_modules.include?(ThemesForRails::ActionController)
  end
end

class ApplicationControllerInclusionTest < ::ActiveSupport::TestCase
  test "include the ActionController module" do
    assert ApplicationController.included_modules.include?(ThemesForRails::ActionController)
  end
end

module ThemesForRails
  module ActionController
    class ApplicationControllerTest < ::ActionController::TestCase
      tests ApplicationController

      test "controller class respond_to theme" do
        assert ApplicationController.respond_to?(:theme)
      end

      test "controller instance respond_to theme" do
        assert @controller.respond_to?(:theme)
      end

      test "test store the theme's name" do
        @controller.theme 'default'
        assert_equal @controller.theme_name, 'default'
      end

      test "add the theme's view path to the front of the general view paths when theme is set" do
        antes = @controller.view_paths.size
        @controller.theme 'default'
        assert_equal antes + 1, @controller.view_paths.size
      end

      test "have a proper view path when theme is set" do
        @controller.theme 'default'
        view_path = @controller.view_paths.first
        theme_view_path = File.expand_path(File.join("test", "dummy_app", "themes", "default", "views"))
        assert_equal view_path.to_s, theme_view_path
      end

      test "provide url method to access a given stylesheet file in the current theme" do
        @controller.theme 'default'
        assert_equal @controller.send(:current_theme_stylesheet_path, "style"), "/themes/default/stylesheets/style.css"
      end

      test "provide url method to access a given javascript file in the current theme" do
        @controller.theme 'default'
        assert_equal @controller.send(:current_theme_javascript_path, "app"), "/themes/default/javascripts/app.js"
      end

      test "provide url method to access a given image file in the current theme" do
        @controller.theme 'default'
        assert_equal @controller.send(:current_theme_image_path, "logo.png"), "/themes/default/images/logo.png"
      end

      test "provide url method to access a given stylesheet file in the current theme with multiple dots" do
        @controller.theme 'default'
        assert_equal @controller.send(:current_theme_stylesheet_path, "style.compact"), "/themes/default/stylesheets/style.compact.css"
      end

      test "provide url method to access a given javascript file in the current theme with multiple dots" do
        @controller.theme 'default'
        assert_equal @controller.send(:current_theme_javascript_path, "app.min"), "/themes/default/javascripts/app.min.js"
      end
    end
  end
end

module ThemesForRails
  module ActionController
    class MyControllerTest < ::ActionController::TestCase
      tests MyController

      test "class method set the selected theme for all actions using a String" do
        MyController.theme 'default'
        @controller.expects(:set_theme).with('default')
        assert_nil @controller.theme_name
        get :hello
      end
    end
  end
end

module ThemesForRails
  module ActionController
    class CustomThemeControllerTest < ::ActionController::TestCase
      tests CustomThemeController

      test "call the selected public method with Symbol" do
        CustomThemeController.theme :theme_selector
        get :hello
        assert_equal 'custom', @controller.theme_name
      end
    end
  end
end

module ThemesForRails
  module ActionController
    class PrivateCustomThemeControllerTest < ::ActionController::TestCase
      tests PrivateCustomThemeController

      test "call the selected private method with Symbol" do
        PrivateCustomThemeController.theme :private_theme_selector
        get :hello
        assert_equal 'private_custom', @controller.theme_name
      end
    end
  end
end
