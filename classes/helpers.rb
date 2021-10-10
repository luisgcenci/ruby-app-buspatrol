# frozen_string_literal: true

#
# General helper functions
#
class Helpers
  #
  # Checks if GeoJSON is an array or a Hash
  #
  # @param +geojson+ [Array or Hash] Array of GeoJSON Objects or a Geometry Collection
  #
  def self.check_geojson_class(geojson)
    case geojson
    when Array
      Db.save_geo(geojson)
    when Hash
      Db.save_geo(geojson['geometries'])
    end
  end
end
