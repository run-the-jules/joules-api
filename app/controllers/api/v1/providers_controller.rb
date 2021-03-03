class Api::V1::ProvidersController < ApplicationController
  def index
    providers = ProvidersFacade.get_providers
    render json: ProvidersSerializer.new(providers), status: 200
  end
end
