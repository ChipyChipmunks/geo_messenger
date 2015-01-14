Meteor.subscribe("rooms")

Template.rooms.helpers ( 
  roomList : -> Rooms.find({}, { sort: { name: 1 }}).fetch()
)

Template.rooms.events(
  'submit #room_form': (evt, template) -> 
    input = template.find('#new_room')
    text = input.value 
    console.log('input' ,text)
    Rooms.insert (
      name: text
      creation_date: new Date()
    )
    input.value=''
    input.focus()
    false
  
  'click .trash': -> 
    Meteor.call('remove_room', @_id)
)
