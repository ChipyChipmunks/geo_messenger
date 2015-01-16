Messages = new Mongo.Collection("messages")
Rooms = new Mongo.Collection("Rooms")
Markers = new Mongo.Collection("Markers")

root = exports ? this

root.Messages = Messages
root.Rooms = Rooms
root.Markers = Markers