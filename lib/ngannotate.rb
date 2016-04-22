module Ngannotate
  def self.sprockets_v2?
    gem = Gem.loaded_specs['sprockets']
    !(gem.version.to_s =~ /\A2\..*\z/).nil?
  end
end

require 'ngannotate/rails'
