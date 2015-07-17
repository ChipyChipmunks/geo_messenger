Messages = new Mongo.Collection("messages")
Topics = new Mongo.Collection("topics")
Logs = new Mongo.Collection("log")

Topics.attachSchema new SimpleSchema(
  name:
    type: String
    label: "name"
    max: 30

  owner:
    type: String
    autoValue: ->
      Meteor.userId()
    autoform:
      omit: true
)

Logs.allow (
	insert: (userId, doc) -> userId && doc.owner == userId
	fetch: ['owner']
)

Topics.allow(
  insert: (userId, doc) -> userId && doc.owner == userId
  remove: (userId, doc) -> doc.owner == userId
  update: (userId, doc) -> doc.owner == userId
  fetch: ['owner']
)

Topics.deny(
  insert: (userId, doc) -> doc.name.trim() == ''
  update: (userId, doc, fields) -> _.contains(fields, 'owner') && doc.name.trim() == ''
)

Topics.find({}).observe(
  removed: (doc) -> Messages.remove({topics_id: doc._id})
)

Messages.attachSchema new SimpleSchema(
  message:
    type: String
    label: "message"
    
  owner:
    type: String
    autoValue: ->
        Meteor.userId()
      autoform:
        omit: true
)
  
#Messages.allow(
#  insert: (userId, doc) -> userId && doc.user == userId 
#  remove: (userId, doc) -> doc.user == userId
#  update: (userId, doc) -> doc.user == userId
#  fetch: ['user']
#)

Messages.deny(
  insert: (userId, doc) -> doc.text.trim() == ''
  update: (userId, doc, fields) -> _.contains(fields, 'user') && doc.text.trim() == ''
)

root = exports ? this

root.Messages = Messages
root.Topics = Topics
root.Logs = Logs

