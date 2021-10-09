docker-compose up -d db
docker-compose run db bash
psql --host=db --username=postgres --dbname=gps_collector
docker build --tag hello .

psql commands

#check which database you're in
SELECT current_database();

#switch to another database
/c <db to switch to>



[
    {
        "type": "Point",
        "coordinates": [100.0, 0.0]
    },
    {
        "type": "Point",
        "coordinates": [32.0, 5.0]
    },
    {
        "type": "Polygon",
        "coordinates": [
            [
                [100.0, 0.0],
                [101.0, 0.0],
                [101.0, 1.0],
                [100.0, 1.0],
                [100.0, 0.0]
            ]
        ]
    },
    {
        "type": "Polygon",
        "coordinates": [
            [
                [100.0, 0.0],
                [101.0, 0.0],
                [101.0, 1.0],
                [100.0, 1.0],
                [100.0, 0.0]
            ],
            [
                [100.8, 0.8],
                [100.8, 0.2],
                [100.2, 0.2],
                [100.2, 0.8],
                [100.8, 0.8]
            ]
        ]
    },
    {
        "type": "MultiLineString",
        "coordinates": [
            [
                [100.0, 0.0],
                [101.0, 1.0]
            ],
            [
                [102.0, 2.0],
                [103.0, 3.0]
            ]
        ]
    }
]


{
    "type": "GeometryCollection",
    "geometries": [{
        "type": "Point",
        "coordinates": [100.0, 0.0]
    }, {
        "type": "LineString",
        "coordinates": [
            [101.0, 0.0],
            [102.0, 1.0]
        ]
    }]
}