require 'spec_helper'

describe 'Sign Up' do
  it 'displays home page after successful sign up' do
    visit new_user_registration_path
    fill_in 'First name',    with: 'Moses'
    fill_in 'Last name',     with: 'Song'
    fill_in 'Email',         with: 'foo@bar.baz'
    fill_in 'user_password', with: 'password'
    click_button 'Sign up'

    expect(page).to have_text('Welcome aboard')
  end

  it 'displays error when first name is missing' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: "First name can't be blank")
  end

  it 'displays error when last name is missing' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: "Last name can't be blank")
  end

  it 'displays error when email is missing' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: "Email can't be blank")
  end

  it 'displays error when email is incorrectly formatted' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'foo'
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: 'Email is invalid')
  end

  it 'displays error when password is missing' do
    visit new_user_registration_path
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: "Password can't be blank")
  end

  it 'displays error when password is too short' do
    visit new_user_registration_path
    fill_in 'user_password', with: 'bar'
    click_button 'Sign up'

    expect(page).to have_selector('#error_explanation', text: 'Password is too short (minimum is 6 characters)')
  end
end
