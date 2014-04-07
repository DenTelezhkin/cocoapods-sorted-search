# encoding: UTF-8
$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'rspec'

def fixture(name)
  File.read(File.dirname(__FILE__) + "/fixtures/#{name}")
end
