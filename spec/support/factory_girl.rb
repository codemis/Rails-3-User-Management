module FactoryGirlTestHelpers
  def attributes_for(klass)
    hashed = {}
    Factory.attributes_for(klass.to_sym).map {|k, v| hashed.merge!(k.to_s => v)}.flatten
    hashed
  end
end