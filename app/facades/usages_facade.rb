class UsagesFacade
  class << self
    def utility_info(id)
    endpoint = "/api/v1/users/#{id}/usage"
      UsageService.kwh_usage(endpoint, id)
    end
  end
end
