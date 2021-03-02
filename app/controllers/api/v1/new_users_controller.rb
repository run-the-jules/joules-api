class Api::V1::NewUsersController < ApplicationController
  def index
    data = UsageService.new_user(params)
    if data[:data] && data[:data][:url]
      render json: data[:data][:url]
    else
      render json: data, status: 400
    end
  end
end
