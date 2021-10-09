# frozen_string_literal: true

require_relative './db.rb'

class Points
  #
  # Gets All GeoJSON Points in the DB within a given Polygon
  #
  # @param +geojson_polygon+ [GeoJSON] a GeoJSON Polygon
  #
  # @return [Array] An array of GeoJSON Points
  #

  def self.points_within_polygon(geojson_polygon)

    conn = Db.db_conn
    result = []

    begin
      conn.exec("SELECT  ST_AsGeoJSON(geometries_geom) \
                FROM Geometries \
                WHERE ST_Within(geometries_geom, ST_GeomFromGeoJSON('#{geojson_polygon.to_json}'));") do |r|
        r.each do |row|
          result.push(row.values)
        end
      end
    result
    rescue PG::InternalError
      "Error: Parameter needs to be a valid GeoJSON"
    end
  end

  #
  # Gets All GeoJSON Points in the DB within a given radius around a given point
  #
  # @param +geojson_point+ [GeoJSON] a central GeoJSON Point <br>
  # @param +radius+ [Integer] a radius 
  #
  # @return [Array] An array of GeoJSON Points
  #
  def self.points_within_radius_around_a_point(geojson_point, radius)

    conn = Db.db_conn
    result = []

    begin
      conn.exec("SELECT ST_AsGeoJSON(geometries_geom) \
                FROM Geometries \
                WHERE ST_DWithin(ST_GeomFromGeoJSON('#{geojson_point.to_json}'), geometries_geom, #{radius});") do |r|
        r.each do |row|
          result.push(row.values)
        end
      end
      result
    rescue PG::InternalError
      "Error: First Parameter needs to be a valid GeoJSON"
    rescue PG::UndefinedColumn
      "Error: Second Parameter needs to be an Integer"
    rescue PG::SyntaxError
      "Error: Second Parameter needs to be an Integer"
    end
  end
end