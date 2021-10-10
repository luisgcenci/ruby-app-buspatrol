# frozen_string_literal: true

# !/usr/bin/ruby

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require_relative './classes/geopoints'
require_relative './classes/helpers'
$stdout.sync = true

##
# Saves an array of GeoJSON Point Objects or a Geometry Collection to the DB. <br>
# GeoJSON Objects should be sent in the body <br>
# Responds with a "Saved" Message
post '/points' do
  arr_geojson = JSON.parse(request.body.read)

  begin
    raise TypeError unless [Array, Hash].member? arr_geojson.class
  rescue TypeError
    status 400
    body "Please send an Array of GeoJSON \
    Points or a Geometry Collection Object in the body with your request."
    break
  end

  Helpers.check_geojson_class(arr_geojson)
end

##
# Receives a GeoJSON Point and a Radius <br>
# GeoJSON Point should be sent in the body <br>
# Radius should be sent as an URL Parameter <br>
# Responds with all the GeoJSON points in the DB within a radius around the GeoJSON Point received
get '/points-within-radius/:radius' do
  geojson_point = JSON.parse(request.body.read)
  radius = params['radius']

  begin
    radius = Float(radius)
  rescue ArgumentError
    status 400
    body 'This endpoint takes a number as an URL parameter.'
    break
  end

  begin
    raise TypeError unless geojson_point.is_a?(Hash)
  rescue TypeError
    status 400
    body 'Please send a GeoJSON point in the body with your request.'
    break
  end

  result = GeoPoints.gpoints_within_radius(geojson_point, radius)

  result.to_s
end

##
# Receives a GeoJSON Polygon (no holes) <br>
# GeoJSON Polygon should be sent in the body <br>
# Responds with all GeoJSON points whitin the GeoJSON Polygon received
get '/points-within-polygon' do
  geojson_polygon = JSON.parse(request.body.read)

  begin
    raise TypeError unless geojson_polygon.is_a?(Hash)
  rescue TypeError
    status 400
    body 'Please send a GeoJSON point in the body with your request.'
    break
  end

  result = GeoPoints.gpoints_within_poly(geojson_polygon)

  result.to_s
end
