Meteor.subscribe("messages")

screenUpdateDep = new Tracker.Dependency;

Meteor.setInterval((-> screenUpdateDep.changed()), 30000)

Template.textInput.events(
  'submit #ourForm': (evt, template) -> 
    input = template.find('#messagebox')
    text = input.value 
    if Rooms.findOne({_id:@room_id})!=undefined
      Messages.insert (
        room_id: @room_id
        text: text
        user: Meteor.user()._id
        email: Meteor.user().emails[0].address
        position: Geolocation.currentLocation()
        date: new Date()
      )
      input.value=''
      input.focus()
    false
)

Template.room.helpers(
  name : -> Rooms.findOne({_id:(this.room_id)}).name
)

Template.message.events(
  'click .trash' : -> (Messages.remove(this._id))
  'click .arrow' : -> console.log('Its working')
  'click .message' : -> console.log(this) 
)

Template.messages.helpers ( 
  messages : -> Messages.find({room_id:@room_id}).fetch()
)

Template.message.helpers (
#  time : -> moment(@date).fromNow()
  time : -> screenUpdateDep.depend(); moment(@date).fromNow()
  room : -> @room_id
)

#Template.map.events (
#  'click #map' : -> 
#   console.log('click', map)
#)
  

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

  map.on "click", (e) ->
    marker = new L.marker(e.latlng)
    marker.addTo(map).bindPopup('name <br> message jdflkd kjdflkjd klfjdlksajf jkfdlsajflk jdkslajfdlks jfdkslajfdlks jfdklsajf ds fjkdlsajf lkasdjf lkasdjf lkasdjf ').openPopup()
    Markers.insert(Marker: marker)
    console.log(Markers)
    return

#  # add a marker in the given location, attach some popup content to it and open the popup
#  L.marker([
#    -41.2889,
#    174.7772
#  ]).addTo(map).bindPopup('A pretty CSS3 popup. <br> Easily customizable.').openPopup()
  
  
  