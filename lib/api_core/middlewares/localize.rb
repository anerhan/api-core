module ApiCore
  module Middlewares
    class Localize
      def initialize(app)
        @app = app
      end

      def call(env)
        apply_locale(env)
        @app.call(env)
      end

      private

      def apply_locale(env)
        lang = env['HTTP_ACCEPT_LANGUAGE'] || env['HTTP_CONTENT_LANGUAGE']
        return unless lang
        header_locale = lang.scan(/^[a-z]{2}/)&.first&.downcase
        return unless header_locale
        locale = ApiCore.config.i18n['locales'].detect { |_k, l| l['aliases'].include?(header_locale) }
        return unless locale
        I18n.locale = locale[0]
      end
    end
  end
end
