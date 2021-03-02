class ProvidersService
  def self.retrieve_providers
    response = Faraday.get('https://joules-microservice.herokuapp.com/api/v1/utilities')

    JSON.parse(response.body, symbolize_names: true)[:data]
  end
end