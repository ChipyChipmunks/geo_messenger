Template.map.rendered = ->
  #console.log(this)
  # create a map in the "map" div, set the view to a given place and zoom
  map = L.map('map').setView([
    -41.2889,
    174.7772
  ], 11)
  
  #DEFAULT MAP TILE
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

#WAIKATO RURAL
  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1872/EPSG:3857/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

#WHANGANUI URBAN
  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1870/EPSG:3857/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

#WELLINGTON RURAL
  L.tileLayer('http://tiles-a.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=2108/EPSG:3857/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

  #WELLINGTON URBAN
  L.tileLayer('http://tiles-{s}.data-cdn.linz.govt.nz/services;key=797491db1b0d4205a1ebec10910d9de3/tiles/v4/layer=1871/EPSG:3857/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

  L.Icon.Default.imagePath = 'https://raw.githubusercontent.com/bevanhunt/meteor-leaflet/master/images'

#  map.on "click", (e) ->
#    marker = new L.marker(e.latlng)
#    marker.addTo(map).bindPopup('name <br> message').openPopup()
#    return

  addMessage = (message) ->
    latlng = L.latLng(message.position[0],message.position[1])
    marker = new L.marker(latlng)
    console.log(marker)
    marker.addTo(map).bindPopup(message.text).openPopup()
    
  remove_marker = (message) ->
    map.removeLayer(latlng = L.latLng(message.position[0], message.position[1]))
    
  Messages.find({room_id:@data.room_id}).observe(
    added: addMessage
    removed: (o) -> console.log 'removed', o
    changed: (n,o) -> console.log 'changed', o, n
  )