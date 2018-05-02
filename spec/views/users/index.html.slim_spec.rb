require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    @users = create_list(:user, 2)
  end

  it 'renders a list of users' do
    render
    assert_select 'tbody tr', @users.count
  end
end
