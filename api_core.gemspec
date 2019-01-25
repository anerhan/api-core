lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_core/version'

Gem::Specification.new do |spec|
  spec.name          = 'api-core'
  spec.version       = ApiCore::VERSION
  spec.authors       = ['Dmitriy Bielorusov']
  spec.email         = ['d.belorusov@gmail.com']

  spec.summary       = %q{Core for microservices based APIs}
  spec.description   = %q{Core for microservices based APIs.}
  spec.homepage      = 'https://dev.azure.com/competommc/UMICO/api-core.git'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://dev.azure.com/competommc/UMICO/api-core.git'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://dev.azure.com/competommc/UMICO/api-core.git'
    spec.metadata['changelog_uri'] = 'https://dev.azure.com/competommc/UMICO/api-core/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-rails'
  spec.add_dependency 'warden'
  spec.add_dependency 'jwt'
  spec.add_dependency 'rails', '~> 5.2.2'
  spec.add_dependency 'i18n'
  spec.add_dependency 'waterdrop'
  spec.add_dependency 'ruby-kafka', '~> 0.6.8'
  spec.add_dependency 'elasticsearch-rails'
  spec.add_dependency 'elasticsearch-model'
end
