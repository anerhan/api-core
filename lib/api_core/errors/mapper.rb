module ApiCore
  module Errors
    class Mapper
      class << self
        def error(opts = {})
          error = ApiCore.config.errors.detect { |m| m[:label] == opts[:label].to_s }

          return { message: "Unprocessible entity, #{opts[:label]}", code: 422 } unless error

          error[:message] = opts[:message] if opts[:message]
          error[:code] = opts[:code] if opts[:code]
          error
        end
      end
    end
  end
end
