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
      owner_email: Meteor.user().emails[0].address
    )
    input.value=''
    input.focus()
  'click .trash': -> 
    Rooms.remove(@_id)
)


