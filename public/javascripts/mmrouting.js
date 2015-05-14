// initialise the map with your choice of API
var mapstraction;
var setStart = false, setEnd = false;
var start = new Marker(new LatLonPoint(48.1513694, 11.5704511));
start.setIcon("/multimodal_munich/images/dd-start.png");
var end = new Marker(new LatLonPoint(48.149710, 11.497536));
end.setIcon("/multimodal_munich/images/dd-end.png");
var startAddress = new Object();
var endAddress = new Object();
var switch_point_markers = [];
var currentbasemap = "google";

dojo.require("esri.map");
var um_basemap;
var um_srs = new esri.SpatialReference({
    wkid: 102113
});
var epsg4326_srs = new Proj4js.Proj('EPSG:4326');
var google_srs = new Proj4js.Proj('GOOGLE');
Proj4js.defs["SR-ORG:45"] = "+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +units=m +no_defs";
var srorg45_srs = new Proj4js.Proj('SR-ORG:45');
var um_start = new Proj4js.Point(11.5704511, 48.1513694);
var um_end = new Proj4js.Point(11.497536, 48.149710);
Proj4js.transform(epsg4326_srs, google_srs, um_start);
Proj4js.transform(epsg4326_srs, google_srs, um_end);
var um_start_symbol = new esri.symbol.PictureMarkerSymbol("/multimodal_munich/images/dd-start.png", 20, 34);
var um_end_symbol = new esri.symbol.PictureMarkerSymbol("/multimodal_munich/images/dd-end.png", 20, 34);
var um_start_marker = new esri.Graphic(new esri.geometry.Point(um_start.x, um_start.y, um_srs), um_start_symbol);
//var um_start_marker = new esri.Graphic(new esri.geometry.Point(1287484.1710666437, 6132378.433136938, um_srs), um_start_symbol);
var um_end_marker = new esri.Graphic(new esri.geometry.Point(um_end.x, um_end.y, um_srs), um_end_symbol);
var um_paths = [];

var ruby_paths, paths, georuby_point;

var zoomLevel = 14;
var centerPoint = new LatLonPoint((48.1513694 + 48.149710)/2, (11.5704511 + 11.497536)/2);
var um_centerPointTrans = new Proj4js.Point((11.5704511 + 11.497536)/2, (48.1513694 + 48.149710)/2);
Proj4js.transform(epsg4326_srs, google_srs, um_centerPointTrans);
var um_centerPoint = new esri.geometry.Point(um_centerPointTrans.x, um_centerPointTrans.y, um_srs);
var geocoder = new MapstractionGeocoder(geocodeSuccHandler, 'google', geocodeErrorHandler);

var UnitedMapsRoutableArea = new Polyline([new LatLonPoint(48.227411, 11.451870),
    new LatLonPoint(48.227411, 11.625010),
    new LatLonPoint(48.076710, 11.625010),
    new LatLonPoint(48.076710, 11.451870),
    new LatLonPoint(48.227411, 11.451870)]);

var bboxUnitedMaps = new BoundingBox(48.076710, 11.451870, 48.227411, 11.625010);
var geometry={};
if(window.innerWidth)
{
    geometry.getViewportWidth=function(){
        return window.innerWidth;
    }
    geometry.getViewportHeight=function(){
        return window.innerHeight;
    }
}else if(document.documentElement && document.documentElement.clientWidth)
{
    geometry.getViewportWidth=function(){
        return document.documentElement.clientWidth;
    }
    geometry.getViewportHeight=function(){
        return document.documentElement.clientHeight;
    }
}else if(document.body && document.body.clientWidth)
{
    geometry.getViewportWidth=function(){
        return document.body.clientWidth;
    }
    geometry.getViewportHeight=function(){
        return document.body.clientHeight;
    }
}

window.onload=function()
{
    if (!geometry.getViewportHeight || !geometry.getViewportWidth)
    {
        geometry.getViewportWidth=function(){
            return document.body.clientWidth;
        }
        geometry.getViewportHeight=function(){
            return document.body.clientHeight;
        }
    }
    changeSize();
    window.onresize=function(){
        changeSize();
    }
    mapstraction = new Mapstraction('google_map','google');
    mapstraction.addMarker(start);
    mapstraction.addMarker(end);
    mapstraction.addEventListener('click', setRoutingPointMarker);
    // display the map centered on a latitude and longitude (Google zoom levels)
    mapstraction.setCenterAndZoom(centerPoint, zoomLevel);

    mapstraction.addControls({
        pan: true,
        zoom: 'large',
        map_type: true
    });

    mapstraction.mousePosition("coordinates");

    dojo.addOnLoad(initUmBasemap);
    document.getElementById('um_map').style.display = 'none';
}

function changeSize()
{
    document.getElementById('main_table').style.height=geometry.getViewportHeight() + 'px';
    document.getElementById('info_div').style.height=geometry.getViewportHeight() - 100 - 19 - 40 - 19 + 'px';
    document.getElementById('map_column').style.width=geometry.getViewportWidth() - 306 + 'px';
}

function initUmBasemap()
{
    um_basemap = new esri.Map("um_map");
    dojo.connect(um_basemap, "onLoad", function()
    {
        dojo.connect(um_basemap, "onMouseMove", showUmCoordinates);
        dojo.connect(um_basemap, "onClick", umMapMouseClickHandler);
        um_basemap.centerAndZoom(um_centerPoint, zoomLevel);
        um_basemap.graphics.add(um_start_marker);
        um_basemap.graphics.add(um_end_marker);
    });
    var tiledMapServiceLayer = new esri.layers.ArcGISTiledMapServiceLayer("http://94.100.75.2/ArcGIS/rest/services/MUC_Basemap/MapServer");
    um_basemap.addLayer(tiledMapServiceLayer);
}

function showUmCoordinates(evt)
{
    var mp = new Proj4js.Point(evt.mapPoint.x, evt.mapPoint.y);
    Proj4js.transform(google_srs, epsg4326_srs, mp);
    dojo.byId("coordinates").innerHTML = mp.y + "/ " + mp.x;
}

function geocodeSuccHandler(geocoded_location)
{
    // create a marker positioned at a lat/lon
    if (currentbasemap == "unitedmaps")
        setRoutingPointMarkerOnUmMap(geocoded_location.point);
    else
        setRoutingPointMarker(geocoded_location.point);

    var address = geocoded_location.address;
    if (setStart == true)
        start.setInfoBubble(address);
    else if (setEnd == true)
        end.setInfoBubble(address);
}

function geocodeErrorHandler(response)
{
    alert('No matched place found!\n Select on the map directly by clicking please. ');
}

function displayLoading()
{
    document.getElementById("loading_sign").style.display = "block";
    document.getElementById("routing_result").style.display = "none";
    document.getElementById("do_calculation").disabled = true;
    document.getElementById("do_calculation").value = "Please wait...";
    setStart = false;
    setEnd = false;
    mapstraction.removeAllPolylines();
    removeAllPathsOnUmMap();
    removeAllSwitchPointMarkers();
}

function displayResults()
{
    document.getElementById("loading_sign").style.display = "none";
    document.getElementById("routing_result").style.display = "block";
    document.getElementById("do_calculation").disabled = false;
    document.getElementById("do_calculation").value = "Calculate";
}

function setNeedParkingState(checked)
{
    var needParkingCtrl = document.getElementById("need_parking");
    if (checked == true)
        needParkingCtrl.disabled = false;
    else
    {
        needParkingCtrl.disabled = true;
        needParkingCtrl.checked = false;
    }
}

function setPublicTransitListState(checked)
{
    var suburbanCtrl = document.getElementById("suburban");
    var undergroundCtrl = document.getElementById("underground");
    var tramCtrl = document.getElementById("tram");
    var busCtrl = document.getElementById("bus");
    var objectiveCtrl = document.getElementById("objective")
    if (checked == true)
    {
        suburbanCtrl.disabled = false;
        suburbanCtrl.checked = true;
        undergroundCtrl.disabled = false;
        undergroundCtrl.checked = true;
        tramCtrl.disabled = false;
        tramCtrl.checked = true;
        // bus is unavailable so far
        busCtrl.disabled = true;
        busCtrl.checked = false;
        document.getElementById("public_transit_list").style.display = "block";
        // disable the "shortest" option for public transit
        objectiveCtrl.options[1].disabled = true;
        objectiveCtrl.options[0].selected = true;
    }
    else
    {
        suburbanCtrl.disabled = true;
        suburbanCtrl.checked = false;
        undergroundCtrl.disabled = true;
        undergroundCtrl.checked = false;
        tramCtrl.disabled = true;
        tramCtrl.checked = false;
        busCtrl.disabled = true;
        busCtrl.checked = false;
        document.getElementById("public_transit_list").style.display = "none";
        objectiveCtrl.options[1].disabled = false;
    }
}

function setPublicTransitState()
{
    var suburbanCtrl = document.getElementById("suburban");
    var undergroundCtrl = document.getElementById("underground");
    var tramCtrl = document.getElementById("tram");
    var busCtrl = document.getElementById("bus");
    var publicTransitCheckedBox = document.getElementById("can_use_public_transit");
    var publicTransitDiv = document.getElementById("public_transit_list");
    var objectiveCtrl = document.getElementById("objective")

    if (suburbanCtrl.checked == false && undergroundCtrl.checked == false && tramCtrl.checked == false && busCtrl.checked == false)
    {
        publicTransitCheckedBox.checked = false;
        objectiveCtrl.options[1].disabled = false;
    }
    else
    {
        publicTransitDiv.style.display = "block";
        publicTransitCheckedBox.checked = true;
        objectiveCtrl.options[1].disabled = true;
        objectiveCtrl.options[0].selected = true;
    }
}

function removeAllPathsOnUmMap()
{
    var i;
    for (i = 0; i < um_paths.length; i++)
        um_basemap.graphics.remove(um_paths[i]);
    um_paths = [];
}

function removeAllSwitchPointMarkers()
{
    var i;
    for (i = 0; i < switch_point_markers.length; i++)
        mapstraction.removeMarker(switch_point_markers[i]);
    switch_point_markers = [];
}

function changeToMapView(map_div, provider)
{
    currentbasemap = provider;
    if (provider == 'unitedmaps')
    {
        document.getElementById('google_map').style.display = 'none';
        document.getElementById('osm_map').style.display = 'none';
        document.getElementById('um_map').style.display = 'block';
        removeAllPathsOnUmMap();
        removeAllSwitchPointMarkers();
    }
    else
    {
        document.getElementById('um_map').style.display = 'none';
        document.getElementById(map_div).style.display = 'block';
        mapstraction.removeAllPolylines();
        removeAllSwitchPointMarkers();
        mapstraction.swap(map_div, provider);
        switchRoutableArea(document.getElementById('routable_area').checked);
    }
}

function changeState(state)
{
    if (state == 'start')
    {
        setStart = true;
        setEnd = false;
        startAddress.address = document.getElementById('start').value;
    }
    else if (state == 'end')
    {
        setStart = false;
        setEnd = true;
        endAddress.address = document.getElementById('end').value;
    }
}

function setRoutingPointByGeocoding(state)
{
    changeState(state);
    if (state == 'start')
        geocoder.geocode(startAddress);
    else if (state == 'end')
        geocoder.geocode(endAddress);
}

function setRoutingPointMarkerOnUmMap(latlonPt)
{
    if (setStart || setEnd)
    {
        var mp = new Proj4js.Point(latlonPt.lon, latlonPt.lat);
        Proj4js.transform(epsg4326_srs, google_srs, mp);
        var marker_point = new esri.geometry.Point(mp.x, mp.y, um_srs);
        if (bboxUnitedMaps.contains(latlonPt))
        {
            // TODO: Remove all existing old paths on the map if there are
            if (setStart)
            {
                um_basemap.graphics.remove(um_start_marker);
                um_start_marker = new esri.Graphic(marker_point, um_start_symbol);
                um_basemap.graphics.add(um_start_marker);
                document.getElementById("start").value = latlonPt.lat + ', ' + latlonPt.lon;
                document.getElementById("start_coordinate").value = latlonPt.lat + ', ' + latlonPt.lon;
            }
            else if (setEnd)
            {
                um_basemap.graphics.remove(um_end_marker);
                um_end_marker = new esri.Graphic(marker_point, um_end_symbol);
                um_basemap.graphics.add(um_end_marker);
                document.getElementById("end").value = latlonPt.lat + ', ' + latlonPt.lon;
                document.getElementById("end_coordinate").value = latlonPt.lat + ', ' + latlonPt.lon;
            }
        }
        else
            alert("out of routable area!");
    }
}

function umMapMouseClickHandler(evt)
{

    if (setStart || setEnd)
        alert('Please select the START/END points on Google or OpenStreetMap base map');
}

function setRoutingPointMarker(arg)
{
    //alert('Mapstraction Event Handling - Mouse clicked at ' + p);
    if (setStart || setEnd)
    {
        if (bboxUnitedMaps.contains(arg))
        {
            mapstraction.removeAllPolylines();
            removeAllSwitchPointMarkers();
            if (setStart)
            {
                mapstraction.removeMarker(start);
                start = new Marker(arg);
                document.getElementById("start").value = arg.toString();
                document.getElementById("start_coordinate").value = arg.toString();
                start.setIcon("/multimodal_munich/images/dd-start.png");
                mapstraction.addMarker(start);
            }
            else if (setEnd)
            {
                mapstraction.removeMarker(end);
                end = new Marker(arg);
                document.getElementById("end").value = arg.toString();
                document.getElementById("end_coordinate").value = arg.toString();
                end.setIcon("/multimodal_munich/images/dd-end.png");
                mapstraction.addMarker(end);
            }
        }
        else
            alert("out of routable area!");
    }
}

function switchRoutableArea(checked)
{
    if (checked == true)
        showRoutableArea();
    else
        hideRoutableArea();
}

function showRoutableArea()
{
    mapstraction.removePolyline(UnitedMapsRoutableArea);
    mapstraction.addPolyline(UnitedMapsRoutableArea);
    mapstraction.setCenterAndZoom(new LatLonPoint((48.227411 + 48.076710) / 2, (11.451870 + 11.625010) / 2), 12);
}

function hideRoutableArea()
{
    mapstraction.removePolyline(UnitedMapsRoutableArea);
}


