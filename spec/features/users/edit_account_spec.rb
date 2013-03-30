require 'spec_helper'

describe 'Edit Account' do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as user
  end

  it 'updates email' do
    visit edit_user_registration_path
    fill_in 'user_email',            with: 'foo@bar.baz'
    fill_in 'user_current_password', with: user.password
    click_button 'Update'

    visit edit_user_registration_path
    expect(page).to have_field('user_email', with: 'foo@bar.baz')
  end

  it 'fails to update email when new one is invalid' do
    visit edit_user_registration_path
    fill_in 'user_email',            with: 'foo'
    fill_in 'user_current_password', with: user.password
    click_button 'Update'

    expect(page).to have_selector('#error_explanation', text: 'Email is invalid')
  end

  it 'fails to update email when current password is empty' do
    visit edit_user_registration_path
    fill_in 'user_email', with: 'foo'
    click_button 'Update'

    expect(page).to have_selector('#error_explanation', text: "Current password can't be blank")
  end

  it 'updates password' do
    visit edit_user_registration_path
    fill_in 'user_password',              with: 'foobarbaz'
    fill_in 'user_password_confirmation', with: 'foobarbaz'
    fill_in 'user_current_password',      with: user.password
    click_button 'Update'

    visit edit_user_registration_path
    expect(page).to have_text('You updated your account successfully')
  end

  it 'fails to update password when password does not match confirmation' do
    visit edit_user_registration_path
    fill_in 'user_password',              with: 'foobarbaz'
    fill_in 'user_password_confirmation', with: 'foo'
    fill_in 'user_current_password',      with: user.password
    click_button 'Update'

    expect(page).to have_selector('#error_explanation', "Password doesn't match confirmation")
  end

  it 'fails to update password when current password is empty' do
    visit edit_user_registration_path
    fill_in 'user_password',              with: 'foobarbaz'
    fill_in 'user_password_confirmation', with: 'foobarbaz'
    click_button 'Update'

    expect(page).to have_selector('#error_explanation', "Current password can't be blank")
  end

  it 'cancels account' do
    visit edit_user_registration_path
    click_button 'Cancel my account'

    expect(page).to have_text('Welcome aboard')
  end
end
