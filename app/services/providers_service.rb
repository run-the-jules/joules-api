class ProvidersService
  def self.retrieve_providers
    response = Faraday.get('https://joules-microservice.herokuapp.com/utilities')

    JSON.parse(response.body, symbolize_names: true)[:data]
  end
end