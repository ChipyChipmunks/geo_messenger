Meteor.publish 'messages', -> Messages.find()
Meteor.publish 'rooms', -> Rooms.find()
