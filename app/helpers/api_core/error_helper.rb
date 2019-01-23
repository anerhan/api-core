module ApiCore
  module ErrorHelper
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error
      rescue_from Exception, with: :internal_server_error

      def route_not_found_error(*_args)
        page_not_found_error(_args)
      end

      protected

      def internal_server_error(*args)
        message = Rails.env.production? ? 'Service temporary unavailable' : args&.first&.message
        render json: { error: { message: message, code: 500 } }, status: 500
      end

      def record_not_found_error(*_args)
        # TODO: Extend to handle args.first.message
        render json: { error: { message: 'Record not found', code: 404 } }, status: :not_found
      end

      def page_not_found_error(*_args)
        render json: { error: { message: 'Page not found', code: 404 } }, status: :not_found
      end
    end
  end
end
