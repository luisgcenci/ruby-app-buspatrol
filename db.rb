# frozen_string_literal: true

require 'pg'

class Db
  #
  # Creates a connection with the DB
  #
  # @return [PG::Connection] a connection with the DB
  #
  
  @@conn = PG::Connection.open('localhost', 5432, '', '', 'gps_collector', 'postgres', 'mudeiasenha')

  #
  # Saves GeoJSON Objects to the DB
  #
  # @param +geometries+ [Array] An Array of GeoJSON Objects
  #
  def self.save_geometry_to_db(geometries)
    geometries.each do |geometry|
      type = geometry['type']
      db_conn.exec("INSERT INTO Geometries(geometries_type, geometries_geom) \
                VALUES ('#{type}', ST_GeomFromGeoJSON('#{geometry.to_json}'));")
    end
  end

  def self.clear_table(table_name)
    db_conn.exec("DELETE FROM #{table_name}")
  end

  def self.insert(table_name, geometries)
    geometries.each do |geometry|
      type = geometry['type']
      db_conn.exec("INSERT INTO Geometries(geometries_type, geometries_geom) \
                  VALUES ('#{type}', ST_GeomFromGeoJSON('#{geometry.to_json}'));")
    end
  end

  def self.db_conn
    @@conn
  end

end