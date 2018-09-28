lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lm_test/version"

Gem::Specification.new do |spec|
  spec.name          = "lm_test"
  spec.version       = LmTest::VERSION
  spec.authors       = ["Matthieu Gourvénec"]
  spec.email         = ["gourve_m@modulotech.fr"]

  spec.summary       = 'This GEM is used to convert a specific JSON file to CSV.'
  spec.description   = 'This GEM is used to convert a specific JSON file to CSV.'
  spec.homepage      = 'http://example.com'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
