# frozen_string_literal: true

# This conntroller used to display userdetails
class UserdetailsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @users = User.includes(:state, :city).all
  end
end
