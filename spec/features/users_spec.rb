require "rails_helper"

RSpec.feature "Users management", :type => :feature do
  scenario 'Delete user record from table' do
    create_list(:user,2)
    visit '/'
    find(:xpath,".//tbody/tr[1]/td/a").click
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario 'Import users from csv file' do
    visit '/'
    attach_file('file', Rails.root.join('spec/fixtures/csv/valid.csv'))
    click_button 'Import CSV'
    expect(page).to have_selector('tbody tr', count: 2)
  end
end