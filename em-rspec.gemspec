Gem::Specification.new do |s|
  s.platform                  = Gem::Platform::RUBY
  s.name                      = 'em-rspec'
  s.version                   = '0.1'
  s.summary                   = 'Test EventMachine code in RSpec 2'
  s.description               = 'Test EventMachine code in RSpec 2 '

  s.required_ruby_version     = '>= 1.9.1'

  s.author                    = 'Stevie Graham'
  s.email                     = 'sjtgraham@mac.com'
  s.homepage                  = 'http://github.com/stevegraham/em-rspec'

  s.add_dependency              'eventmachine',  '>= 0.12.10'

  s.add_development_dependency  'rspec',         '>= 2.5.0'

  s.files                     = Dir['README.md', 'lib/*']
  s.require_path              = 'lib'
end
