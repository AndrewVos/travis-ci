require 'spec_helper'

describe WorkersController, :type => :controller do
  before(:each) do
    Time.stubs(:now).returns(Time.utc(2011, 11, 11, 11, 11, 11))

    @workers = [
      Factory(:worker, :name => 'worker-1', :state => :working),
      Factory(:worker, :name => 'worker-2', :state => :errored)
    ]
  end

  attr_reader :workers

  it 'index lists all workers' do
    get :index, :format => :json

    json = ActiveSupport::JSON.decode(response.body)
    json.should include({ 'id' => workers.first.id,  'name' => 'worker-1', 'host' => 'ruby-1.workers.travis-ci.org', 'state' => 'working', 'last_seen_at' => '2011-11-11T11:11:11Z' })
    json.should include({ 'id' => workers.second.id, 'name' => 'worker-2', 'host' => 'ruby-1.workers.travis-ci.org', 'state' => 'errored', 'last_seen_at' => '2011-11-11T11:11:11Z' })
  end
end
