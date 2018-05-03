require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    @users = create_list(:user, 2)
    render
  end

  it 'renders a list of users' do
    assert_select 'tbody tr', count: @users.count
  end

  it 'renders a csv import form' do
    assert_select 'form', count: 1
  end
end
