require 'ostruct'

module ApiCore
  class Config < OpenStruct
    def gem_root
      @gem_root ||= Gem::Specification.find_by_name('api-core').gem_dir
    end

    def i18n
      @i18n ||= YAML.load_file(File.join(gem_root, 'config/i18n.yml')).with_indifferent_access
    end

    def available_locales
      i18n[:locales].keys.map(&:to_sym)
    end

    def default_locale
      i18n[:default_locale].to_sym
    end

    def time_zone
      i18n[:time_zone]
    end

    def encoding
      'utf-8'
    end

    def response_headers
      @response_headers ||= YAML.load_file(File.join(gem_root, 'config/response_headers.yml'))
    end

    def errors
      @errors ||= YAML.load_file(File.join(gem_root, 'config/errors.yml'))
    end
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
