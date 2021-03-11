require 'rails_helper'

RSpec.describe "DemoPages", type: :system do
  before do
    #driven_by(:rack_test)
    driven_by(:selenium_chrome_headless)
  end

  it "should render home page" do
    visit "/"
    expect(page).to have_content('Demo')
  end

  context "login" do
    it "as superadmin" do
      visit "/"
      click_link "Log in"
      fill_in "Email", with: "superadmin@gmail.com"
      fill_in "Password", with: "superadmin123"
      click_button "Log in"
      expect(page).to have_content('User details')
    end

    it "as admin" do
      visit "/"
      click_link "Log in"
      fill_in "Email", with: "admin@gmail.com"
      fill_in "Password", with: "admin123"
      click_button "Log in"
      expect(page).to have_content('Employee details')
    end

    it "as Employee" do
      visit "/"
      click_link "Log in"
      fill_in "Email", with: "employee@gmail.com"
      fill_in "Password", with: "employee123"
      click_button "Log in"
      expect(page).to have_content('employee@gmail.com')
    end
    
    it "when email and password is blank" do
      visit '/'
      click_link "Log in"
      click_button "Log in"
      expect(page).to have_content("Invalid Email or password.")
    end
  end

  it "sign up user" do
    visit '/'
    click_link "Sign up"
    fill_in "Name", with: "test"
    fill_in "Email", with: "test@gmail.com"
    fill_in "Phone", with: '4567891231'
    choose(option: 'male')
    select 'Gujarat', from: 'user_state_id' 
    select 'Surat', from: 'user_city_id'
    fill_in "Password", with: '1234567'
    fill_in "Password confirmation", with: '1234567'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
    within('.container') do
      expect(page).to have_text('test')
    end 
  end
end