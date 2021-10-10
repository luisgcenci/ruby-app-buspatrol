# frozen_string_literal: true

require_relative '../classes/db'

#
# GeoJSON Point Object
#
class GeoPoints
  #
  # Executes a SQL code
  #
  # @param sql [String] sql a sql code
  #
  # @return result [Arr] A result of the sql code
  #
  def self.exec_sql(sql)
    result = []
    Db.db_conn.exec(sql) do |r|
      r.each do |row|
        result.push(row.values)
      end
    end
    result
  rescue PG::InternalError, PG::UndefinedColumn, PG::SyntaxError => e
    "#{e.class}: Parameter needs to be a valid GeoJSON"
  end

  #
  # Gets All GeoJSON Points in the DB within a given Polygon
  #
  # @param +geojson_polygon+ [GeoJSON] a GeoJSON Polygon
  #
  # @return [Array] An array of GeoJSON Points
  #
  def self.gpoints_within_poly(geojson_polygon)
    sql = "SELECT  ST_AsGeoJSON(geometries_geom) \
        FROM Geometries \
        WHERE ST_Within(geometries_geom, ST_GeomFromGeoJSON('#{geojson_polygon.to_json}'));"
    exec_sql(sql)
  end

  #
  # Gets All GeoJSON Points in the DB within a given radius around a given point
  #
  # @param +geojson_point+ [GeoJSON] a central GeoJSON Point <br>
  # @param +radius+ [Integer] a radius
  #
  # @return [Array] An array of GeoJSON Points
  #
  def self.gpoints_within_radius(geojson_point, radius)
    sql = "SELECT ST_AsGeoJSON(geometries_geom) \
          FROM Geometries \
          WHERE ST_DWithin(ST_GeomFromGeoJSON('#{geojson_point.to_json}'), geometries_geom, #{radius});"
    exec_sql(sql)
  end
end
