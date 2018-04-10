require 'serverspec'
require 'net/http'
require 'uri'

# Required by serverspec
set :backend, :exec


describe 'flask service' do
  it 'is listening on port 5000' do
    expect(port(5000)).to be_listening
  end
  it 'has a running service of flask' do
    expect(service('flask')).to be_running
  end
  describe Net::HTTP.get(URI('http://localhost:5000/health')) do
    it { should eq('Health Check Ok') }
  end
end

