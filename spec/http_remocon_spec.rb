require 'spec_helper'

describe HttpRemocon do

  def app
    HttpRemocon::Application
  end

  it 'says hello' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq 'hello'
  end
end
