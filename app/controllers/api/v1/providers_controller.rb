class Api::V1::ProvidersController < ApplicationController
  def index
    # response = Faraday.get('https://joules-microservice.herokuapp.com/utilities')

    # data = JSON.parse(response.body, symbolize_names: true)[:data]

    # providers = data.map do |provider_data|
    #   Provider.new(provider_data)
    # end

    providers = ProvidersFacade.get_providers
    render json: ProvidersSerializer.new(providers), status: 200
  end
end