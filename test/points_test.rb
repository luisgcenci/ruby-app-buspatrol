require "test/unit"
require_relative '../classes/points.rb'
require_relative '../classes/db.rb'

class PointsTest < Test::Unit::TestCase

  # Clear Table "Geometries"
  Db.clear_table("Geometries")

  # Insert Data in "Geometries Table" For Testing 
  Db.save_geometry_to_db([
    {
      "type": "Point",
      "coordinates": [-1.0, 0.0]
    },
    {
      "type": "Point",
      "coordinates": [-0.5, 0.0]
    },
    {
      "type": "Point",
      "coordinates": [3.0, 1.0]
    },
    {
      "type": "Point",
      "coordinates": [0.0, 2.0]
    },
    {
      "type": "Point",
      "coordinates": [0.0, -2.0]
    },
    {
      "type": "Point",
      "coordinates": [-2.0, 2.0]
    },
    {
      "type": "Point",
      "coordinates": [1.0, -4.0]
    },
    {
      "type": "Point",
      "coordinates": [2.0, 5.0]
    }
  ])

  def test_points_within_polygon

    geojson_polygon = {
      "type": "Polygon",
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

    assert_equal [
      ["{\"type\":\"Point\",\"coordinates\":[-0.5,0]}"], 
      ["{\"type\":\"Point\",\"coordinates\":[3,1]}"], 
      ["{\"type\":\"Point\",\"coordinates\":[0,2]}"], 
      ["{\"type\":\"Point\",\"coordinates\":[0,-2]}"]
    ], Points.points_within_polygon(geojson_polygon)

    not_valid_geojson = {"type": "not valid geojson"}
    
    # Throws an error message when something other than a valid GeoJSON is passed as a parameter
    assert_equal("PG::InternalError: Parameter needs to be a valid GeoJSON", Points.points_within_polygon(2))
    assert_equal("PG::InternalError: Parameter needs to be a valid GeoJSON", Points.points_within_polygon("String"))
    assert_equal("PG::InternalError: Parameter needs to be a valid GeoJSON", Points.points_within_polygon(not_valid_geojson))

  end

  def test_points_within_radius_around_a_point
    geojson_point = {
      "type": "Point",
      "coordinates": [2.0, 1.0]
    }
    radius = 3

    assert_equal [
      [
        "{\"type\":\"Point\",\"coordinates\":[-0.5,0]}"
      ],
      [
        "{\"type\":\"Point\",\"coordinates\":[3,1]}"
      ],
      [
        "{\"type\":\"Point\",\"coordinates\":[0,2]}"
      ]
    ], Points.points_within_radius_around_a_point(geojson_point, radius)

    not_valid_geojson = {"type": "not valid geojson"}
    
    # Throws an error message when something other than a valid GeoJSON is passed as first parameter
    assert_equal("PG::InternalError: First Parameter needs to be a valid GeoJSON",Points.points_within_radius_around_a_point(not_valid_geojson, 1))
    assert_equal("PG::InternalError: First Parameter needs to be a valid GeoJSON",Points.points_within_radius_around_a_point(1, 1))
    assert_equal("PG::InternalError: First Parameter needs to be a valid GeoJSON",Points.points_within_radius_around_a_point("String", 1))

    # Throws an error message when something other than a Numeric Object is passed as second parameter
    assert_equal("SyntaxError Error: Second Parameter needs to be an Integer", Points.points_within_radius_around_a_point(geojson_point, not_valid_geojson))
    assert_equal("UndefinedColumn Error: Second Parameter needs to be an Integer", Points.points_within_radius_around_a_point(geojson_point, "String"))
  end
end