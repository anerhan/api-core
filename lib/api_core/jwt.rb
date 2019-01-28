require 'jwt'

module ApiCore
  class JWT
    class << self
      def encode(payload)
        unless ApiCore.config.jwt_validation
          return ::JWT.encode(payload, ApiCore.config.jwt_password, 'none', { algorithm: ApiCore.config.jwt_algo,  typ: 'JWT' })
        end

        case ApiCore.config.jwt_algo
        when 'HS256'
          ::JWT.encode payload, ApiCore.config.jwt_secret, ApiCore.config.jwt_algo
        when 'RS256'
          ::JWT.encode payload, ApiCore.config.jwt_secret, ApiCore.config.jwt_algo
        else
          nil
        end
      rescue JWT::EncodeError => _e
        nil
      end

      def decode(token)
        case ApiCore.config.jwt_algo
        when 'HS256'
          ::JWT.decode(token, ApiCore.config.jwt_secret, ApiCore.config.jwt_validation, { algorithm: ApiCore.config.jwt_algo }).first
        when 'RS256'
          ::JWT.decode(token, ApiCore.config.jwt_secret, ApiCore.config.jwt_validation, { algorithm: ApiCore.config.jwt_algo, typ: 'JWT' }).first
        else
          nil
        end
      rescue ::JWT::ExpiredSignature => _e
        nil
      rescue ::JWT::DecodeError => _e
        nil
      end
    end
  end
end
