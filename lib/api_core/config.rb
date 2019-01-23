require 'ostruct'

module ApiCore
  class Config < OpenStruct
  end

  class << self
    def configure(&_block)
      yield config
    end

    def config
      @config ||= ApiCore::Config.new
    end

    def info
      {
        info: {
          name: config.app_name,
          organization: config.organization,
          versions: config.supported_versions,
          time_zone: config.time_zone,
          encoding: config.encoding,
          delivered_at: config.delivered_at.strftime('%c')
        }
      }
    end
  end
end
