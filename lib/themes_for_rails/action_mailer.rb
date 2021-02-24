# frozen_string_literal: true

module ThemesForRails
  module ActionMailer
    def mail(headers = {}, &block)
      theme_opts = headers[:theme] || self.class.default[:theme]
      theme(theme_opts) if theme_opts

      super(headers, &block)
    end
  end
end
