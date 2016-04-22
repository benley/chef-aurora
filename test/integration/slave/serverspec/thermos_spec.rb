require 'serverspec'

set :backend, :exec

describe 'Thermos observer' do

  it 'is running' do
    sv_name = 'thermos'
    if os[:family] == 'redhat' then sv_name = 'thermos-observer' end
    expect(service sv_name).to be_running
  end

  it 'is listening on tcp/1338' do
    expect(port 1338).to be_listening
  end
end
