require "test/unit"
require_relative '../classes/db.rb'

class DbTest < Test::Unit::TestCase

  # Clear Table "Geometries"
  Db.clear_table("Geometries")

  def test_save_geometry_to_db

    geometries = [
      {
      "type": "Point",
      "coordinates": [2.0, 1.0]
      },
      {
        "type": "LineString",
        "coordinates": [
          [100.0, 0.0],
          [101.0, 1.0]
        ]
      }
    ]

    not_valid_geojson = {"type": "not a valid geojson"};
    not_valid_array_geojson = [
      {"type": "not a valid geojson"},
      {"type": "not a valid geojson2"}
    ]

    assert_equal "Saved", Db.save_geometry_to_db(geometries)

    # Prints an error message when something other than a valid Array of GeoJSON Objects is passed as a parameter
    assert_equal "NoMethodError: Parameter needs to be an Array of GeoJSON Objects", Db.save_geometry_to_db(2)
    assert_equal "NoMethodError: Parameter needs to be an Array of GeoJSON Objects", Db.save_geometry_to_db("string")
    assert_equal "TypeError: Parameter needs to be an Array of GeoJSON Objects", Db.save_geometry_to_db(not_valid_geojson)
    assert_equal "PG::InternalError: Parameter needs to be an Array of GeoJSON Objects", Db.save_geometry_to_db(not_valid_array_geojson)

  end

  def test_clear_table

    # Throws an error message when trying to clear a table that doesn't exist 
    assert_equal "PG::UndefinedTable: Relation 'Customer' does not exist", Db.clear_table("Customer")

    # Throws an error message when trying pass something other than a String as a parameter 
    assert_equal "PG::SyntaxError: Argument needs to be a String", Db.clear_table(2)
    assert_equal "PG::SyntaxError: Argument needs to be a String", Db.clear_table({"type": "Hash"})
    assert_equal "PG::SyntaxError: Argument needs to be a String", Db.clear_table([{"type": "Array"}])
  end
end