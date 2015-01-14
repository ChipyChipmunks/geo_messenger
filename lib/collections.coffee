Messages = new Mongo.Collection("messages")
Rooms = new Mongo.Collection("Rooms")

root = exports ? this

root.Messages = Messages
root.Rooms = Rooms