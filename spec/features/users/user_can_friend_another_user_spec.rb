# Background: A user (Josh) exists in the system with a Github token. The user has two followers on Github.
#  One follower (Dione) also has an account within our database. The other follower (Mike) does not have an account in our
# system. If a follower or
# following has an account in our system we want to include a link next to their name to allow us to add as a friend.

require 'rails_helper'

describe "As a user we can go to our dashboard" do
  scenario "we see a link to friend a follower or followee if they are in our database", :vcr do
    token = ENV["GITHUB_TOKEN_LOCAL"]
    user_1 = create(:user, token: token)
    user_2 = create(:user, uid: "37692413")
    user_3 = create(:user, uid: "40702808")
    user_4 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    allow_any_instance_of(ApplicationController).to receive(:github_status).and_return("logged in")

    visit dashboard_path

    within (".github_followers") do
      expect(page).to have_link("Friend this User")
      click_link "Friend this User"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('You have added a friend.')

    within (".github_following") do
      expect(page).to have_link("Friend this User")
      click_link "Friend this User"
    end

    within ('.friends') do
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_2.last_name)
      expect(page).to have_content(user_3.first_name)
      expect(page).to have_content(user_3.last_name)
      expect(page).not_to have_content(user_4.first_name)
    end
  end
end
