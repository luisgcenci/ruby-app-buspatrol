# frozen_string_literal: true

require 'test/unit'
require_relative '../classes/db'
#
# Test Class for the DB Class
#
class DbTest < Test::Unit::TestCase
  # Clear Table "Geometries"
  Db.clear_table('Geometries')

  @geometries = [
    {
      "type": 'Point',
      "coordinates": [2.0, 1.0]
    },
    {
      "type": 'LineString',
      "coordinates": [
        [100.0, 0.0],
        [101.0, 1.0]
      ]
    }
  ]

  @not_valid_geojson = { "type": 'not a valid geojson' }
  @not_valid_array_geojson = [
    { "type": 'not a valid geojson' },
    { "type": 'not a valid geojson2' }
  ]

  def test_save_geo
    assert_equal 'Saved', Db.save_geo(@geometries)

    # Throws an error message when something other than a valid Array of GeoJSON Objects is passed as a parameter
    error_mes = 'Parameter needs to be an Array of GeoJSON Objects'
    assert_equal "NoMethodError: #{error_mes}", Db.save_geo(2)
    assert_equal "NoMethodError: #{error_mes}", Db.save_geo('string')
    assert_equal "TypeError: #{error_mes}", Db.save_geo(@not_valid_geojson)
    assert_equal "PG::InternalError: #{error_mes}", Db.save_geo(@not_valid_array_geojson)
  end

  def test_clear_table
    # Throws an error message when trying to clear a table that doesn't exist
    assert_equal "PG::UndefinedTable: Relation 'Customer' does not exist", Db.clear_table('Customer')

    # Throws an error message when trying pass something other than a String as a parameter
    error_mes = 'Argument needs to be a String'
    assert_equal "PG::SyntaxError: #{error_mes}", Db.clear_table(2)
    assert_equal "PG::SyntaxError: #{error_mes}", Db.clear_table({ "type": 'Hash' })
    assert_equal "PG::SyntaxError: #{error_mes}", Db.clear_table([{ "type": 'Array' }])
  end
end
