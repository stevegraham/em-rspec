begin
  require 'fiber'
rescue LoadError
  raise LoadError.new "em-rspec requires the Fiber class. (Available in core Ruby 1.9)"
end

require 'eventmachine'

RSpec::Core::Example.class_eval do
  alias ignorant_run run

  def run(example_group_instance, reporter)
    if metadata[:eventmachine]
      result = false
      Fiber.new do
        EM.run do
          df = EM::DefaultDeferrable.new
          df.callback { |x| EM.stop }
          result = ignorant_run(example_group_instance, reporter)
          df.succeed
        end
      end.resume
      result
    else
      ignorant_run(example_group_instance, reporter)
    end
  end

end
