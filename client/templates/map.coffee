my_map = {}

messageClick = ->
  console.log(this)
  
Template.map.rendered = ->
  map = L.map('map').setView([
    -41.2889,
    174.7772
  ], 11)
  root = exports ? @ 
  root.my_map = map
  
  L.tileLayer('https://{s}.tiles.mapbox.com/v3/examples.map-i875mjb7/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

  L.Icon.Default.imagePath = 'https://raw.githubusercontent.com/bevanhunt/meteor-leaflet/master/images'

#  map.on "click", (e) ->
#    marker = new L.marker(e.latlng)
#    marker.addTo(map).bindPopup('name <br> message').openPopup()
#    return

  markers = new L.MarkerClusterGroup({ spiderfyOnMaxZoom: true})
#  markers.on "click", (a) ->
#    console.log a

#function messageClick(e) {console.log(e.attributes["data-message-id"].childNodes[0]);}
#$('#messages_div').scrollTo($('.message[data-target="#ePcMmvvwWhybtckXD"]').position().top);

#    return
#
#  markers.on "clusterclick", (a) ->
#    console.log "cluster " + a.layer.getAllChildMarkers().length
#    return
  addMessage = (message) ->
    
#      markers = new L.MarkerClusterGroup()
#      markers.addLayer(new L.Marker(getRandomLatLng(map)))
#      map.addLayer(markers)

#    latlng = L.latLng(message.position[0], message.position[1])
#    marker = new L.marker(latlng)
#    console.log(marker)

    latlng = L.latLng(message.position[0], message.position[1])
    marker = new L.Marker(latlng)
    
    marker.bindPopup(message.text + '<br><a onclick="messageClick(this)" data-message-id="'+message._id+'">View Message</a>')
    
    markers.addLayer(marker)
#    map.addLayer(new L.Marker(latlng))
  map.addLayer(markers)
    #marker.addTo(map).bindPopup(message.text).openPopup()
    
  Messages.find({room_id:@data.room_id}).observe(
    added: addMessage
    removed: (o) -> console.log 'removed', o
    changed: (n,o) -> console.log 'changed', o, n
  )

