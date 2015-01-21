Messages = new Mongo.Collection("messages")
Rooms = new Mongo.Collection("Rooms")

Rooms.allow(
  insert: (userId, doc) -> userId && doc.owner == userId
  remove: (userId, doc) -> doc.owner == userId
  update: (userId, doc) -> doc.owner == userId
  fetch: ['owner']
)

Rooms.deny(
  insert: (userId, doc) -> doc.name.trim() == ''
  update: (userId, doc, fields) -> _.contains(fields, 'owner') && doc.name.trim() == ''
)

Rooms.find({}).observe(
  removed: (doc) -> Messages.remove({room_id: doc._id})
  
#  added: (doc) -> 
#    if Messages.find({room_id:doc._id}).count() == 0
#      Messages.insert 
#        room_id: doc._id
#        text: 'Welcome to the new room!'
#        user: ''
#        email: 'administrator'
#        position: [0,0]
#        date: new Date()
      
)

Messages.allow(
  insert: (userId, doc) -> userId && doc.user == userId 
  remove: (userId, doc) -> doc.user == userId
  update: (userId, doc) -> doc.user == userId
  fetch: ['user']
)

Messages.deny(
  insert: (userId, doc) -> doc.text.trim() == ''
  update: (userId, doc, fields) -> _.contains(fields, 'user') && doc.text.trim() == ''
)

root = exports ? this

root.Messages = Messages
root.Rooms = Rooms


if Meteor.isServer
  Meteor.publish "messages", ->
    Messages.find()
  Meteor.publish "rooms", ->
    Rooms.find()

if Meteor.isClient
  Meteor.subscribe "messages"
  Meteor.subscribe "rooms"