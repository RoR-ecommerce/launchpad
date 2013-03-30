require 'spec_helper'

describe 'Login' do
  it 'displays home page after successful login' do
    user = FactoryGirl.create(:user)

    visit   new_user_session_path
    fill_in 'user_email',    with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    expect(page).to have_text('Welcome aboard')
  end

  it 'displays error when no credential submitted' do
    visit new_user_session_path
    click_button 'Sign in'

    expect(page).to have_selector('#flash_alert', text: 'Invalid email or password.')
  end

  it 'displays error when email is missing' do
    visit new_user_session_path
    fill_in 'user_password', with: 'foobarbaz'
    click_button 'Sign in'

    expect(page).to have_selector('#flash_alert', text: 'Invalid email or password.')
  end

  it 'displays error when password is missing' do
    visit new_user_session_path
    fill_in 'user_email', with: 'foo@bar.baz'
    click_button 'Sign in'

    expect(page).to have_selector('#flash_alert', text: 'Invalid email or password.')
  end
end
