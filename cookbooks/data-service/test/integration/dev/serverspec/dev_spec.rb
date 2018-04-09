require 'serverspec'
require 'net/http'
require 'uri'

# Required by serverspec
set :backend, :exec

users = [
  { 'name' => 'jdeploy', 'uid' => 50_002 }
]

groups = [
  { 'name' => 'jdeploy', 'gid' => 50_002 }
]

describe 'System settings' do
  users.each do |user|
    describe user(user['name']) do
      it { should exist }
      it { should have_uid user['uid'] }
    end
  end

  groups.each do |group|
    describe group(group['name']) do
      it { should exist }
      it { should have_gid group['gid'] }
    end
  end

end


describe 'flask service' do
  it 'is listening on port 5000' do
    expect(port(9000)).to be_listening
  end
  it 'has a running service of flask' do
    expect(service('flask')).to be_running
  end
  describe Net::HTTP.get(URI('http://localhost:5000/health')) do
    it { should eq('Health Check Ok') }
  end
end

