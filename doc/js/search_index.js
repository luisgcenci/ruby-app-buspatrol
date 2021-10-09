var search_data = {"index":{"searchIndex":["object","/points()","/points-within-polygon()","/points-within-radius/:radius()","check_geojson_class()","db_conn()","points_within_polygon()","points_within_radius_around_a_point()","save_geometry_to_db()","dockerfile","gemfile","gemfile.lock","readme.md","config.ru"],"longSearchIndex":["object","object#/points()","object#/points-within-polygon()","object#/points-within-radius/:radius()","object#check_geojson_class()","object#db_conn()","object#points_within_polygon()","object#points_within_radius_around_a_point()","object#save_geometry_to_db()","","","","",""],"info":[["Object","","Object.html","",""],["/points","Object","Object.html#method-i-2Fpoints","","<p>Saves an array of GeoJSON Point Objects or a Geometry Collection to the DB.\n<p>GeoJSON Objects should be …\n"],["/points-within-polygon","Object","Object.html#method-i-2Fpoints-2Dwithin-2Dpolygon","","<p>Receives a GeoJSON Polygon (no holes)\n<p>GeoJSON Polygon should be sent in the body\n<p>Responds with all GeoJSON …\n"],["/points-within-radius/:radius","Object","Object.html#method-i-2Fpoints-2Dwithin-2Dradius-2F-3Aradius","","<p>Receives a GeoJSON Point and a Radius\n<p>GeoJSON Point should be sent in the body\n<p>Radius should be sent as …\n"],["check_geojson_class","Object","Object.html#method-i-check_geojson_class","(geojson)","<p>Checks if GeoJSON is an array or a Hash\n<p>@param <code>geojson</code> [Array or Hash] Array of GeoJSON Objects or a  …\n"],["db_conn","Object","Object.html#method-i-db_conn","()","<p>Creates a connection with the DB\n<p>@return [PG::Connection] a connection with the DB\n"],["points_within_polygon","Object","Object.html#method-i-points_within_polygon","(geojson_polygon)","<p>Gets All GeoJSON Points in the DB within a given Polygon\n<p>@param <code>geojson_polygon</code> [Hash] a GeoJSON Polygon …\n"],["points_within_radius_around_a_point","Object","Object.html#method-i-points_within_radius_around_a_point","(geojson_point, radius)","<p>Gets All GeoJSON Points in the DB within a given radius around a given point\n<p>@param <code>geojson_point</code> [Hash] …\n"],["save_geometry_to_db","Object","Object.html#method-i-save_geometry_to_db","(geometries)","<p>Saves GeoJSON Objects to the DB\n<p>@param <code>geometries</code> [Array] An Array of GeoJSON Objects\n"],["Dockerfile","","Dockerfile.html","","<p># Include Ruby Image FROM ruby:2.7.4\n<p># Put all files in a dir called /code WORKDIR /code COPY . /code …\n"],["Gemfile","","Gemfile.html","","<p># frozen_string_literal: true\n<p>source &#39;rubygems.org&#39;\n<p>gem &#39;pg&#39; gem &#39;sinatra&#39; gem …\n"],["Gemfile.lock","","Gemfile_lock.html","","<p>GEM\n\n<pre>remote: https://rubygems.org/\nspecs:\n  multi_json (1.15.0)\n  mustermann (1.1.1)\n    ruby2_keywords ...</pre>\n"],["README.md","","README_md_txt.html","","<p>docker-compose up -d db\ndocker-compose run db bash\npsql --host=db --username=postgres --dbname=gps_collector ...\n"],["config.ru","","config_ru.html","","<p># frozen_string_literal: true\n<p>require &#39;./app&#39;\n<p>run Sinatra::Application\n"]]}}