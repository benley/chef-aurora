require 'serverspec'

set :backend, :exec

describe 'Aurora scheduler' do

  it 'is running' do
    sv_name = 'aurora-scheduler'
    if os[:family] == 'redhat' then sv_name = 'aurora' end
    expect(service sv_name).to be_running
  end

  it 'is listening on port 8081' do
    expect(port(8081)).to(be_listening)
  end
end
