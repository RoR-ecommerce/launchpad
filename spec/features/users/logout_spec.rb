require 'spec_helper'

describe 'Logout' do
  it 'redirects to home page after successful logout' do
    login_as FactoryGirl.create(:user)

    # any page with navigation that has logout
    visit edit_user_registration_path
    click_link 'Logout'

    expect(page).to have_text('Welcome aboard')
  end
end
