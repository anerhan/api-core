module ApiCore
  module Warden
    module Strategies
      class Base < ::Warden::Strategies::Base
        def jwt_token
          request.env['HTTP_AUTHORIZATION'].try(:sub, /\ABearer\s/, '')
        end
      end
    end
  end
end
