require "rails_helper"

RSpec.feature "Users management", :type => :feature do
  before :each do
    create_list(:user,2)
  end

  scenario 'Delete user record from table' do
    visit '/'
    find(:xpath,".//tbody/tr[1]/td/a").click
    expect(page).to have_selector('tbody tr', count: 1)
  end
end