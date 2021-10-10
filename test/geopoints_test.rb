# frozen_string_literal: true

require 'test/unit'
require_relative '../classes/points'
require_relative '../classes/db'

#
# Test Class for GeoPoints Class
#
class GeoPointsTest < Test::Unit::TestCase
  # Clear Table "Geometries"
  Db.clear_table('Geometries')

  @arr_geopoints = [
    {
      "type": 'Point',
      "coordinates": [-1.0, 0.0]
    },
    {
      "type": 'Point',
      "coordinates": [-0.5, 0.0]
    },
    {
      "type": 'Point',
      "coordinates": [3.0, 1.0]
    },
    {
      "type": 'Point',
      "coordinates": [0.0, 2.0]
    },
    {
      "type": 'Point',
      "coordinates": [0.0, -2.0]
    },
    {
      "type": 'Point',
      "coordinates": [-2.0, 2.0]
    },
    {
      "type": 'Point',
      "coordinates": [1.0, -4.0]
    },
    {
      "type": 'Point',
      "coordinates": [2.0, 5.0]
    }
  ]

  @geojson_point = {
    "type": 'Point',
    "coordinates": [2.0, 1.0]
  }

  @radius = 3

  @geojson_polygon = {
    "type": 'Polygon',
    "coordinates": [
      [
        [-1.0, 4.0],
        [5.0, 4.0],
        [5.0, -3.0],
        [-1.0, -3.0],
        [-1.0, 4.0]
      ]
    ]
  }

  @not_valid_geojson = { "type": 'not valid geojson' }

  # Insert Data in "Geometries Table" For Testing
  Db.save_geometry_to_db(@arr_geopoints)

  def test_gpoints_within_poly
    assert_equal [
      ["{\"type\":\'Point\',\"coordinates\":[-0.5,0]}"],
      ["{\"type\":\'Point\',\"coordinates\":[0,2]}"],
      ["{\"type\":\'Point\',\"coordinates\":[0,-2]}"]
    ], Points.points_within_polygon(@geojson_polygon)

    # Throws an error message when something other than a valid GeoJSON is passed as a parameter
    error_msg = 'Parameter needs to be a valid GeoJSON'
    assert_equal("PG::InternalError: #{error_msg}", Points.gpoints_within_poly(2))
    assert_equal("PG::InternalError: #{error_msg}", Points.gpoints_within_poly('String'))
    assert_equal("PG::InternalError: #{error_msg}", Points.gpoints_within_poly(@not_valid_geojson))
  end

  def test_gpoints_within_radius
    assert_equal [
      ["{\"type\":\'Point\',\"coordinates\":[-0.5,0]}"],
      ["{\"type\":\'Point\',\"coordinates\":[0,2]}"]
    ], Points.points_gpoints_within_radius(@geojson_point, @radius)

    # Throws an error message when something other than a valid GeoJSON is passed as first parameter
    error_msg = 'First Parameter needs to be a valid GeoJSON'
    assert_equal("PG::InternalError: #{error_msg}", Points.gpoints_within_radius(@not_valid_geojson, 1))
    assert_equal("PG::InternalError: #{error_msg}", Points.gpoints_within_radius(1, 1))
    # Throws an error message when something other than a Numeric Object is passed as second parameter
    error_msg = 'Second Parameter needs to be an Integer'
    assert_equal("SyntaxError Error: #{error_msg}", Points.gpoints_within_radius(@geojson_point, @not_valid_geojson))
    assert_equal("UndefinedColumn Error: #{error_msg}", Points.gpoints_within_radius(@geojson_point, 'String'))
  end
end
