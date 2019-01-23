module ApiCore
  module Warden
    module Strategies
      class Base < ::Warden::Strategies::Base
        def jwt_token
          request.env['HTTP_AUTHORIZATION']
        end
      end
    end
  end
end
