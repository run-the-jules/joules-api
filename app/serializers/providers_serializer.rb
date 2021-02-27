class ProvidersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end