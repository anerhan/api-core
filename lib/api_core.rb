require 'api_core/version'

require 'rails/engine'
require 'action_controller/railtie'

require 'api_core/config'
require 'api_core/errors/mapper'
require 'api_core/jwt'
require 'api_core/models/user'

require 'api_core/middlewares/failure_app'
require 'api_core/middlewares/localize'
require 'api_core/warden/manager'
require 'api_core/warden/strategies/base'
require 'api_core/warden/strategies/jwt_auth'

require 'api_core/engine'

module ApiCore
  class Error < StandardError; end
end

