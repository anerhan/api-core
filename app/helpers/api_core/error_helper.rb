module ApiCore
  module ErrorHelper
    extend ActiveSupport::Concern
    included do
      rescue_from Exception, with: :exception_catcher

      def route_not_found_error(*args)
        render json: { error: { message: 'Page not found', code: 404 } }, status: :not_found
      end

      private

      def exception_catcher(*excs)
         catcher = ApiCore::Errors::Catcher.new(exception: excs.first)
         catcher.process!
         render json: catcher.content, status: catcher.status.to_sym
      end
    end
  end
end
