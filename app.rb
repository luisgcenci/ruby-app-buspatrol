# frozen_string_literal: true

# !/usr/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require_relative './points.rb'
require_relative './db.rb'
require_relative './helpers.rb'
$stdout.sync = true

##
# Saves an array of GeoJSON Point Objects or a Geometry Collection to the DB. <br>
# GeoJSON Objects should be sent in the body <br>
# Responds with a "Saved" Message
post '/points' do
  geojson = JSON.parse(request.body.read)
  Helpers.check_geojson_class(geojson)

  'Saved!'
end

##
# Receives a GeoJSON Point and a Radius <br>
# GeoJSON Point should be sent in the body <br>
# Radius should be sent as an URL Parameter <br>
# Responds with all the GeoJSON points in the DB within a radius around the GeoJSON Point received
get '/points-within-radius/:radius' do
  geojson_point = JSON.parse(request.body.read)
  radius = params['radius']
  radius = radius.to_i
  result = Points.points_within_radius_around_a_point(geojson_point, radius)

  result.to_s
end

##
# Receives a GeoJSON Polygon (no holes) <br>
# GeoJSON Polygon should be sent in the body <br>
# Responds with all GeoJSON points whitin the GeoJSON Polygon received
get '/points-within-polygon' do
  geojson_polygon = JSON.parse(request.body.read)
  result = Points.points_within_polygon(geojson_polygon)

  result.to_s
end


