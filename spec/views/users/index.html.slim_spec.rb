require 'rails_helper'

RSpec.describe 'users/index.html.slim', type: :view do
  before(:each) do
    @users = create_list(:user, 2)
    allow(view).to receive_messages(paginate: nil)
    render
  end

  it 'renders a list of users' do
    assert_select 'tbody tr', count: @users.count
  end

  it 'renders a csv import form' do
    assert_select '#upload_csv', count: 1
  end

  it 'renders filter form' do
    assert_select '#filter', count: 1
  end
end
