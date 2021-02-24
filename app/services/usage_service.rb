class UsageService
  class << self
    def kwh_usage(endpoint, params = {})
      #Update Usage model/table
      response = connection.get(endpoint) do |req|
                   req.params = params
                 end
      parse(response)
    end

    private

    def parse(data)
      JSON.parse(data.body, symbolize_names: true)
    end

    def connection
      Faraday.new('https://mysterious-ravine-12345.herokuapp.com')
      #Use actual URL from Sinatra
    end
  end
end
