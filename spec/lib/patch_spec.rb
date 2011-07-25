require File.expand_path(File.dirname(__FILE__) + '/../../lib/em-rspec.rb')

describe 'async aware rspec' do
  it 'runs examples with eventmachine reactor' do
    EM.reactor_running?.should be_true
  end
end