Meteor.subscribe("messages")

screenUpdateDep = new Tracker.Dependency;

Meteor.setInterval((-> screenUpdateDep.changed()), 30000)

Template.textInput.events(
  'submit #ourForm': (evt, template) -> 
    console.log(Meteor.user().emails[0].address);
    input = template.find('#messagebox')
    text = input.value 
    Messages.insert (
      room_id: @room_id
      text: text
      user: Meteor.user()._id
      email: Meteor.user().emails[0].address
      position: Geolocation.currentLocation()
      date: new Date()
    )
    console.log(Geolocation.currentLocation())
    input.value=''
    input.focus()
    false
)

Template.room.helpers(
  name : -> 'name'
)

Template.message.events(
  'click .trash' : -> (Messages.remove(this._id))
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

Template.map.rendered = ->
  console.log(this)
  # create a map in the "map" div, set the view to a given place and zoom
  map = L.map('map').setView([
    -41.2889,
    174.7772
  ], 13)

  # add an OpenStreetMap tile layer
  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',
    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
  ).addTo map

  # add a marker in the given location, attach some popup content to it and open the popup
  L.marker([
    51.5
    -0.09
  ]).addTo(map).bindPopup('A pretty CSS3 popup. <br> Easily customizable.').openPopup()