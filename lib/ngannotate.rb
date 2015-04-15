module Ngannotate
  def self.sprockets_v3?
    gem = Gem.loaded_specs['sprockets']
    !(gem.version.to_s =~ /\A3\..*\z/).nil?
  end
end

require 'ngannotate/rails'
