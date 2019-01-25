require 'api_core/version'

# INFO: External libs
require 'rails/engine'
require 'action_controller/railtie'
require 'waterdrop'
require 'elasticsearch/rails'
require 'elasticsearch/model'

# INFO: Own libs
require 'api_core/config'
require 'api_core/errors/unprocessable_entity'
require 'api_core/errors/catcher'
require 'api_core/errors/mapper'
require 'api_core/jwt'
require 'api_core/models/user'
require 'api_core/middlewares/failure_app'
require 'api_core/middlewares/localize'
require 'api_core/warden/manager'
require 'api_core/warden/strategies/base'
require 'api_core/warden/strategies/jwt_auth'
require 'api_core/event_bus/client'
require 'api_core/engine'

module ApiCore
  class Error < StandardError; end
end
