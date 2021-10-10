# Ruby App - Buspatrol
Ruby app backed by a Postgres/Postgis database stored in a Docker Container.

# Minimum Dependencies
[Docker](https://docs.docker.com/install/) \
[Docker-Compose](https://docs.docker.com/compose/install/) \
[PSQL](https://www.postgresql.org/download/) \
[Ruby](https://www.ruby-lang.org/en/downloads/) \
[Rack](https://github.com/rack/rack)

## Endpoints

1) `POST` - Accepts GeoJSON point(s) to be inserted into a database table
   params: Array of GeoJSON Point objects or Geometry collection

2) `GET` - Responds w/GeoJSON point(s) within a radius around a point
   params: GeoJSON Point and integer radius in feet/meters

3) `GET` - Responds w/GeoJSON point(s) within a geographical polygon
   params: GeoJSON Polygon with no holes


## Set Up
##### Clone this repo 
```git clone https://github.com/luisgcenci/ruby-app-buspatrol.git```
##### Install Gems
```bundle install```

#### Create an .env file and paste this
```
export DB_ADDRESS=localhost
export DB_PORT=5432
export DB_NAME=gps_collector
export DB_USER=postgres
export DB_PASSWORD=mudeiasenha
```
#### Stand up the Database image
```docker-compose up -d db```
#### Connect to Docker Container
```docker-compose run db bash```
#### Connect to DB withing Docker Container
```psql --host=db --username=postgres --dbname=gps_collector```
#### Create "Geometries" Table in the DB.
```
CREATE TABLE GEOMETRIES(
geometries_id SERIAL,
geometries_type varchar(30) not null,
geometries_geom geometry not null
);
```

## How To Lint
```rubocop```

## How to Test
```ruby ./test/db_test.rb``` \
```ruby ./test/points_test.rb```

## How to Run
```ruby app.rb```

## How to Open Documentation
```cd doc``` \
```start index.html```