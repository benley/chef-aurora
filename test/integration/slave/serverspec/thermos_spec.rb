require 'serverspec'

set :backend, :exec

describe 'Thermos observer' do

  it 'is running' do
    expect(service 'thermos').to be_running
  end

  it 'is listening on tcp/1338' do
    expect(port 1338).to be_listening
  end
end
