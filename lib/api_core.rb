require 'api_core/version'
require 'api_core/config'
require 'api_core/controllers/info_controller'



module ApiCore
  class Error < StandardError; end
end


module ApiCore
  class Engine < Rails::Engine
  end
end
