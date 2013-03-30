require 'spec_helper'

describe 'Forgot Password' do
  it 'displays error when email is missing' do
    visit new_user_password_path
    click_button 'Send me reset password instructions'

    expect(page).to have_selector('#error_explanation', text: "Email can't be blank")
  end

  it 'displays error when email is not found' do
    visit new_user_password_path
    fill_in 'user_email', with: 'doesnotexist@nowhere.com'
    click_button 'Send me reset password instructions'

    expect(page).to have_selector('#error_explanation', text: 'Email not found')
  end

  it 'sends email with instructions' do
    user = FactoryGirl.create(:user)

    visit new_user_password_path
    fill_in 'user_email', with: user.email
    click_button 'Send me reset password instructions'

    expect(page).to have_text('You will receive an email with instructions')
  end
end
