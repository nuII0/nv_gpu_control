Gem::Specification.new do |s|
  s.name        = 'nv_gpu_control'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = 'A ruby gem for configuring Nvidia GPUs on a Linux system.'
  s.authors     = ['nuii0']
  s.email       = 'nuii0@tuta.io'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.md)
  s.homepage    = 'https://rubygems.org/gems/nv_gpu_control'
#  s.metadata    = { 'source_code_uri' => 'https://github.com/example/example' }
  s.add_runtime_dependency 'logging', '~> 2'
  s.add_development_dependency 'rspec', '~> 3'
end
