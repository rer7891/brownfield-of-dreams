require 'rails_helper'

describe 'As a registered user' do
  it 'I can send an email invite to another GitHub user
      by clicking an invite link on my dashboard' do

    token = ENV["GITHUB_TOKEN_LOCAL"]
    user = create(:user, token: token)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    click_button 'Send an Invite'
    expect(current_path).to eq(invite_path)
  end
end
