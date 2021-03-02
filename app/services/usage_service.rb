class UsageService
  class << self
    def fetch_utilities
      response = connection.get("/api/v1/utilities")
      parse(response)
    end

    def new_user(params)
      response = connection.get("/api/v1/new_user") do |req|
        req.params["email"] = params[:email]
        req.params["utility"] = params[:utility]
      end
      parse(response)
    end

    def get_meters(referral)
      response = connection.get("/api/v1/get_meters") do |req|
        req.params["referral"] = referral.to_i
      end
      parse(response)
    end

    def get_bills(meter_uid)
      response = connection.get("/api/v1/bills") do |req|
        req.params["meter_uid"] = meter_uid
      end
      parse(response)
    end

    private

    def parse(data)
      JSON.parse(data.body, symbolize_names: true)
    end

    def connection
      Faraday.new('https://joules-microservice.herokuapp.com/')
    end
  end
end
