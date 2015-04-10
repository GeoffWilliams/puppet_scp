require 'puppet'
require 'puppet/type/scp'
describe Puppet::Type.type(:scp) do
  let(:resource_foo) { Puppet::Type.type(:scp).new(:name => '/foo') }
  it 'should accept ensure'
  it 'should require that name be absolute'

  it 'should accept a valid source URI'
  it 'should not accept an invalid source URI'
end