# em-rspec

em-rspec is a very simple patch to RSpec 2 that sets up and tears down an EventMachine reactor loop, and runs each example within the context of the loop. 
It also will wrap each example in a [Fiber](http://ruby-doc.org/core-1.9/classes/Fiber.html) so you are free to untangle nested callbacks.

# Usage

`gem install em-rspec`

`require 'em-rspec'`

em-rspec extends RSpec in an unobtrusive way that requires no addtional code in your specs to test EM code. e.g.

<pre>describe 'em-rspec' do
  it 'executes specs within a reactor loop' do
    EM.reactor_running?.should be_true # This is true
  end
end</pre>

# How it works

As mentioned before, before the spec is run, a reactor loop is setup, and a callback to teardown the loop on the next tick of the reactor loop is created.
This is an important point to consider because if you do any asynchronous i/o operations, your code will not be tested because the reactor loop is running
precisely one tick. It is an antipattern to actually hit the network in your tests and what you should do is mock out i/o calls to return immediately,
e.g. http calls with [webmock](https://github.com/bblimke/webmock).

This is how your examples are run with em-rspec:

- Set up reactor loop
- Set callback to tear down reactor loop on the next tick
- Wrap example in fiber
- Run before each block
- Run example
- Run after each block
- Crank reactor loop and tear it down.

&copy; 2011 Stevie Graham