--for parking places
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100200000000+g2.nn_gid, 1001, 1002, 2001, 3, TRUE, g1.um_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.um_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM car_parkings) c) AS g1,
(SELECT c.um_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM car_parkings) c) AS g2
WHERE g1.um_id=g2.um_id;
UPDATE switch_points SET switch_point_id=200100000000+id WHERE switch_point_id=0;

--for physical connections
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, g1.vertex_id, g2.vertex_id, 1001, 1002, 2002, 0.5, TRUE, NULL, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT (vertex_id % 100000000) AS junc_id, vertex_id FROM vertices WHERE mode_id=1001) AS g1,
(SELECT (vertex_id % 100000000) AS junc_id, vertex_id FROM vertices WHERE mode_id=1002) AS g2
WHERE g1.junc_id=g2.junc_id;
UPDATE switch_points SET switch_point_id=200200000000+id WHERE switch_point_id=0;

--for P+R lots
--from car to s-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100400000000+g2.nn_gid, 1001, 1004, 2003, 5, TRUE, g1.poi_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.poi_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM park_and_rides) c) AS g1,
(SELECT c.poi_id, (pgis_fn_nn(c.the_geom, 0.003, 1, 10, '(SELECT * FROM suburban_junctions INNER JOIN vertices ON suburban_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1004)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM park_and_rides) c) AS g2
WHERE g1.poi_id=g2.poi_id;
UPDATE switch_points SET switch_point_id=200300000000+id WHERE switch_point_id=0;

--for P+R lots
--from car to u-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100300000000+g2.nn_gid, 1001, 1003, 2003, 5, TRUE, g1.poi_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.poi_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM park_and_rides) c) AS g1,
(SELECT c.poi_id, (pgis_fn_nn(c.the_geom, 0.003, 1, 10, '(SELECT * FROM underground_junctions INNER JOIN vertices ON underground_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1003)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM park_and_rides) c) AS g2
WHERE g1.poi_id=g2.poi_id;
UPDATE switch_points SET switch_point_id=200300000000+id WHERE switch_point_id=0;

--for kiss+R lots
--from car network to s-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100400000000+g2.nn_gid, 1001, 1004, 2008, 2, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM suburban_junctions INNER JOIN vertices ON suburban_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1004)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200800000000+id WHERE switch_point_id=0;

--for kiss+R lots
--from car network to u-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100300000000+g2.nn_gid, 1001, 1003, 2008, 2, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM underground_junctions INNER JOIN vertices ON underground_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1003)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200800000000+id WHERE switch_point_id=0;

--for kiss+R lots
--from car network to tram
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100100000000+g1.nn_gid, 100500000000+g2.nn_gid, 1001, 1005, 2008, 2, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1001)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM tram_junctions INNER JOIN vertices ON tram_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1005)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200800000000+id WHERE switch_point_id=0

--for suburban stations
--from s-bahn stations to pedestrian network
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100400000000+g1.nn_gid, 100200000000+g2.nn_gid, 1004, 1002, 2005, 0, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM suburban_junctions INNER JOIN vertices ON suburban_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1004)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
--from pedestrian network to s-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100200000000+g1.nn_gid, 100400000000+g2.nn_gid, 1002, 1004, 2005, 5, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM suburban_junctions INNER JOIN vertices ON suburban_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1004)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM suburban_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200500000000+id WHERE switch_point_id=0;

--for underground stations
--from u-bahn stations to pedestrian network
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100300000000+g1.nn_gid, 100200000000+g2.nn_gid, 1003, 1002, 2004, 0, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM underground_junctions INNER JOIN vertices ON underground_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1003)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
--from pedestrian network to u-bahn
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100200000000+g1.nn_gid, 100300000000+g2.nn_gid, 1002, 1003, 2004, 5, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM underground_junctions INNER JOIN vertices ON underground_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1003)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM underground_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200400000000+id WHERE switch_point_id=0;

--for tram stations
--from tram stations to pedestrian network
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100500000000+g1.nn_gid, 100200000000+g2.nn_gid, 1005, 1002, 2006, 0, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM tram_junctions INNER JOIN vertices ON tram_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1005)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
--from pedestrian network to tram
INSERT INTO switch_points (switch_point_id, from_vertex_id, to_vertex_id, from_mode_id, to_mode_id, type_id, cost, is_available, ref_poi_id, created_at, updated_at)
SELECT 0, 100200000000+g1.nn_gid, 100500000000+g2.nn_gid, 1002, 1005, 2006, 5, TRUE, g1.type_id, (SELECT LOCALTIMESTAMP), (SELECT LOCALTIMESTAMP) FROM
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM street_junctions INNER JOIN vertices ON street_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1002)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g1,
(SELECT c.type_id, (pgis_fn_nn(c.the_geom, 0.002, 1, 10, '(SELECT * FROM tram_junctions INNER JOIN vertices ON tram_junctions.nodeid=(vertices.vertex_id % 100000000) WHERE vertices.mode_id=1005)', 'true', 'nodeid', 'the_geom')).* FROM (SELECT * FROM tram_stations) c) AS g2
WHERE g1.type_id=g2.type_id;
UPDATE switch_points SET switch_point_id=200600000000+id WHERE switch_point_id=0
