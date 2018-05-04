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
    attach_file('file', Rails.root.join('spec/fixtures/csv/valid.csv'))
    click_button 'Import CSV'
    expect(page).to have_selector('tbody tr', count: 2)
  end
end