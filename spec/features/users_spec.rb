require "rails_helper"

RSpec.feature "Users management" do
  scenario 'deletes user record from table', js: true do
    create_list(:user,2)
    visit '/'
    find(:xpath,".//tbody/tr[1]/td/a").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario 'imports users from csv file', js: true do
    visit '/'
    upload_csv
    click_button 'Import CSV'
    expect(page).to have_selector('.alert-success', count: 1)
  end

  scenario 'filter users by name', js: true do
    create(:user, name: 'Philip')
    create(:user, name: 'David')
    visit '/'
    fill_in 'starts_with', with: 'Phil'
    click_button 'Filter'
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario 'filter users by number', js: true do
    create(:user, number: 1)
    create(:user, number: 2)
    visit '/'
    fill_in 'number', with: '2'
    click_button 'Filter'
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario 'filter users by description', js: true do
    create(:user, description: 'Simple description')
    create(:user, description: 'My Original description')
    visit '/'
    fill_in 'in_description', with: 'original'
    click_button 'Filter'
    expect(page).to have_selector('tbody tr', count: 1)
  end

  scenario 'filter users by description', js: true do
    create(:user, date: Time.now)
    create(:user, date: Time.now - 1.day)
    visit '/'
    fill_in 'date', with: Time.now.strftime('%Y-%m-%d')
    click_button 'Filter'
    expect(page).to have_selector('tbody tr', count: 1)
  end
end

def upload_csv
  attach_file('file', Rails.root.join('spec/fixtures/csv/valid.csv'))
end