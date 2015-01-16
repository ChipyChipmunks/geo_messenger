Meteor.subscribe("rooms")

Template.rooms.helpers ( 
  roomList : -> Rooms.find({}, { sort: { name: 1 }}).fetch()
)

Template.rooms.events(
  'submit #room_form': (evt, template) -> 
    evt.preventDefault()
    input = template.find('#new_room')
    text = input.value 
    console.log('input' ,text)
    Rooms.insert (
      name: text
      creation_date: new Date()
      owner: Meteor.user()._id
    )
    input.value=''
    input.focus()
  
  'click .trash': -> 
    Rooms.remove(@_id)
)


#Template.map.rendered = -> 
#  # create a map in the "map" div, set the view to a given place and zoom
#  map = L.map('map').setView([
#    51.505
#    -0.09
#  ], 13)
#
#  # add an OpenStreetMap tile layer
#  L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',
#    attribution: '&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors'
#  ).addTo map
#
#  # add a marker in the given location, attach some popup content to it and open the popup
#  L.marker([
#    51.5
#    -0.09
#  ]).addTo(map).bindPopup('A pretty CSS3 popup. <br> Easily customizable.').openPopup()


