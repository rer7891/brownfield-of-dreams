class InviteController < ApplicationController
  def new
  end

  def create
    gh_handle = params[:github_handle]
    token = current_user.token
    email = GithubSearch.new(token).get_email(gh_handle)
    require "pry"; binding.pry
  end
end
