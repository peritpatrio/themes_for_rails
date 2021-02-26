# encoding: utf-8
require File.expand_path("test/test_helper.rb")

THEME = 'pink'

class Notifier < ActionMailer::Base
  default :theme => THEME

  def welcome(user)
    mail(subject: 'Welcome', theme: user.theme) do |format|
      format.text { render plain: 'Welcome' }
      format.html { render html: 'Welcome' }
    end
  end

  def thanks(user)
    mail(subject: 'Thanks')  do |format|
      format.text { render plain: 'Thanks' }
      format.html { render html: 'Thanks' }
    end
  end
end

module ThemesForRails
  class ActionMailerTest < ::ActionMailer::TestCase

    test "should set theme using mail headers" do
      Notifier.any_instance.expects(:theme).with("purple")

      user = mock("User", :theme => "purple")
      Notifier.new.welcome(user)
    end

    test "should set theme using mail default opts" do
      Notifier.any_instance.expects(:theme).with("pink")

      user = mock("User")
      Notifier.new.thanks(user)
    end
  end
end
