lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'korbit_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'korbit_api'
  spec.version       = KorbitApi::VERSION
  spec.authors       = ['JungChoon Park']
  spec.email         = ['unlimitedfocus@gmail.com']

  spec.summary       = '(WIP) Ruby wrapper for Korbit API'
  spec.description   = '(WIP) Ruby wrapper for Korbit API https://apidocs.korbit.co.kr/'
  spec.homepage      = 'https://github.com/unlimitedfocus/korbit-api'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.16.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'guard', '~> 2.14.2'
  spec.add_development_dependency 'guard-minitest', '~> 2.4.6'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.59.2'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6.1'
  spec.add_development_dependency 'yard', '~> 0.9.16'
end
