module ApiCore
  module Warden
    module Strategies
      class JwtAuth < Base
        def valid?
          jwt_token.present?
        end

        def decoded_jwt_token
          @jwt_token ||= ApiCore::JWT.decode(jwt_token)
        end

        def authenticate!
          fail!('expired_or_invalid_token') && return unless decoded_jwt_token

          # TODO: Need Implement extractor for additional attributes of user
          success!(
            ApiCore::Models::User.new(
              id: decoded_jwt_token['sub'],
              first_name: 'John',
              last_name: 'Doe',
              role: 'admin',
              email: 'admin@umico.com'
            )
          )
        end
      end
    end
  end
end
