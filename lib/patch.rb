begin
  require 'fiber'
rescue LoadError
  raise LoadError.new "em-rspec requires the Fiber class. (Available in core Ruby 1.9)"
end

require 'eventmachine'

RSpec::Core::Example.class_eval do
  alias ignorant_run run

  def run(example_group_instance, reporter)
    Fiber.new do
      EM.run do
        EM.next_tick { EM.stop }
        ignorant_run example_group_instance, reporter
      end
    end.resume
  end

end