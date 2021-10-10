# frozen_string_literal: true

require 'pg'
require 'dotenv/load'

#
# DataBase
#
class Db
  #
  # Creates a connection with the DB
  #
  # @return [PG::Connection] a connection with the DB
  #
  @conn = PG::Connection.open(
    ENV['DB_ADDRESS'],
    ENV['DB_PORT'],
    '',
    '',
    ENV['DB_NAME'],
    ENV['DB_USER'],
    ENV['DB_PASSWORD']
  )

  #
  # Saves GeoJSON Objects to the DB
  #
  # @param +geometries+ [Array] An Array of GeoJSON Objects
  #
  def self.save_geo(geometries)
    geometries.each do |geometry|
      db_conn.exec(
        "INSERT INTO Geometries(geometries_type, geometries_geom) \
        VALUES ('#{geometry['type']}', ST_GeomFromGeoJSON('#{geometry.to_json}'));"
      )
    end
  rescue NoMethodError, TypeError, PG::InternalError => e
    "#{e.class}: Parameter needs to be an Array of GeoJSON Objects"
  else
    'Saved'
  end

  def self.clear_table(table_name)
    db_conn.exec("DELETE FROM #{table_name}")
  rescue PG::UndefinedTable => e
    "#{e.class}: Relation 'Customer' does not exist"
  rescue PG::SyntaxError => e
    "#{e.class}: Argument needs to be a String"
  end

  def self.db_conn
    @conn
  end
end
