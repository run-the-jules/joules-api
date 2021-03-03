class ProvidersFacade
  def self.get_providers
    data = ProvidersService.retrieve_providers

    data.map do |provider_data|
      Provider.new(provider_data)
    end
  end
end
