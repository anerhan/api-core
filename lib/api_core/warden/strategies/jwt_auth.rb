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
              given_name: decoded_jwt_token['given_name'],
              family_name: decoded_jwt_token['family_name'],
              email_verified: decoded_jwt_token['email_verified'],
              realm_access: decoded_jwt_token['realm_access'],
              resource_access: decoded_jwt_token['resource_access'],
              jti: decoded_jwt_token['jti']
            )
          )
        end
      end
    end
  end
end
