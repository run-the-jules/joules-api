class Provider
  attr_reader :id, :name
  
  def initialize(data)
    @id = data[:id]
    @name = data[:utility_name]
  end
end