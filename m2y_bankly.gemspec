
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "m2y_bankly/version"

Gem::Specification.new do |spec|
  spec.name          = "m2y_bankly"
  spec.version       = M2yBankly::VERSION
  spec.authors       = ["Caio Lopes"]
  spec.email         = ["caio.lopes@mobile2you.com.br"]

  spec.summary       = %q{Bankly Baas API Gem}
  spec.description   = %q{Bankly Baas API Gem}
  spec.homepage      = "http://www.mobile2you.com.br"
  spec.license       = "MIT"


  spec.files = Dir['lib/**/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty"
end
