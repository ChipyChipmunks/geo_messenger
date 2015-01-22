my_map = {}

Template.map.rendered = ->
  #console.log(this)
  # create a map in the "map" div, set the view to a given place and zoom
  map = L.map('map').setView([
    -41.2889,
    174.7772
  ], 11)
  root = exports ? @ 
  root.my_map = map
  
  #DEFAULT MAP TILE
#  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map
  
  L.tileLayer('https://{s}.tiles.mapbox.com/v3/examples.map-i875mjb7/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map


##WAIKATO RURAL
#  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1872/EPSG:3857/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map
#
##WHANGANUI URBAN
#  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1870/EPSG:3857/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map
#
##WELLINGTON RURAL
#  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=2108/EPSG:3857/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map
#
#  #WELLINGTON URBAN
#  L.tileLayer('http://tiles-{s}.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1871/EPSG:3857/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map

  L.Icon.Default.imagePath = 'https://raw.githubusercontent.com/bevanhunt/meteor-leaflet/master/images'

#  map.on "click", (e) ->
#    marker = new L.marker(e.latlng)
#    marker.addTo(map).bindPopup('name <br> message').openPopup()
#    return


##<TOTALLY BLAIR'S CODE. WAY TO GOOD TO BE MINE>
#
  addMessage = (message) ->
    latlng = L.latLng(message.position[0],message.position[1])
    marker = new L.marker(latlng)
    console.log(marker)
    marker.addTo(map).bindPopup(message.text).openPopup()
    
#    
#  remove_marker = (message) ->
#    map.removeLayer(latlng = L.latLng(message.position[0], message.position[1]))
#    
#runOnMarkers = (f) -> 
#  layers = map._layers
#  for key of layers
#   layer = layers[key]
#   if layer._latlng # only markers.
#     f layer
#
#markerIsInLayer = (marker, layer) -> layer._latlng.lat == marker.latlng.lat && layer._latlng.lng == marker.latlng.lng
#runIfMarkerInLayer = (f, marker) -> (layer) -> f(layer) if markerIsInLayer(marker, layer)
#
#removeMarker = (layer) -> map.removeLayer layer
#resetMarker = (layer) -> layer.setIcon redMarker
#
#removeMarkerFromMap = (marker) -> runOnMarkers runIfMarkerInLayer(removeMarker, marker)
#resetAllMarkers = -> runOnMarkers resetMarker
#
#setSelectMarker = (marker) -> runOnMarkers runIfMarkerInLayer((layer) -> layer.setIcon(selectedMarker), marker)
#
##</TOTALLY BLAIR'S CODE. WAY TO GOOD TO BE MINE>
    
  Messages.find({room_id:@data.room_id}).observe(
    added: addMessage
    removed: (o) -> console.log 'removed', o
    changed: (n,o) -> console.log 'changed', o, n
  )

