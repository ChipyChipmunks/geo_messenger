Meteor.methods(
  remove_room: (room_id) -> 
    room = Rooms.findOne(room_id)
  
    console.log('deleting room', room_id, room.name)
    Messages.remove({room_id:room_id})
    Rooms.remove(room_id)
)