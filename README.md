# em-rspec

em-rspec is a very simple patch to RSpec 2 that sets up and tears down
an EventMachine reactor loop, and run examples tagged as
`eventmachine: true` within the context of the loop.
It also will wrap examples in a [Fiber](http://ruby-doc.org/core-1.9/classes/Fiber.html) so you are free to untangle nested callbacks.

# Usage

`gem install em-rspec`

`require 'em-rspec'`

em-rspec extends RSpec so that you can decide which specs are to be executed within the context of a reactor loop:

<pre>describe 'em-rspec' eventmachine: true do
  it 'executes specs within a reactor loop' do
    EM.reactor_running?.should be_true # This is true
  end
end</pre>

# How it works

As mentioned before, before the spec is run, a reactor loop is setup, and a callback to teardown the loop when your example finishes execution is created.
This is an important point to consider because if you do any asynchronous i/o operations, your code will not be tested, because your code will likely have
finished execution before the i/o operation is complete. It is an antipattern to actually hit the network in your tests and what you should do is mock out
i/o calls to return immediately, e.g. http calls with [webmock](https://github.com/bblimke/webmock).

This is how your examples are run with em-rspec:

- Set up reactor loop
- Set callback to tear down reactor loop when spec is finished
- Wrap example in fiber
- Run before each block
- Run example
- Run after each block
- Tear down reactor loop

&copy; 2011 Stevie Graham