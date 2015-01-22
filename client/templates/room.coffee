Meteor.subscribe("messages")

screenUpdateDep = new Tracker.Dependency;

Meteor.setInterval((-> screenUpdateDep.changed()), 30000)

Template.textInput.events(
  'keypress textarea': (e) ->
    if (!e.shiftKey && e.keyCode == 13)
      e.preventDefault()
      $('form#ourForm').submit()
      
  'submit #ourForm': (evt, template) -> 
    evt.preventDefault()
    input = template.find('#messagebox')
    text = input.value 
    if Rooms.findOne({_id:@room_id}) != undefined
      newMessage =
        room_id: @room_id
        text: text
        user: Meteor.user()._id
        email: Meteor.user().emails[0].address
        position: position()
        date: new Date()

      Messages.insert newMessage
      
      input.value = ''
      input.focus()
)

scroll_bottom : -> 
  messages_div = document.getElementById('#messages_div')
  messages_div.scrollTop = messages_div.scrollHeight

position = ->
    pos = Geolocation.currentLocation()
    if pos == null
      pos = [-41.2889, 174.7772] 
    else
      pos = [pos.coords.latitude, pos.coords.longitude]
    pos

Template.room.helpers(
  name : -> room = Rooms.findOne({_id:(@room_id)}); room && room.name
)

Template.message.events(
  'click .trash' : -> (Messages.remove(this._id))
  'click .arrow' : -> console.log('Its working')
  'click .message' : -> console.log(this) 
)

Template.messages.helpers ( 
  messages : -> Messages.find({room_id:@room_id},{sort: { date: 1 }}).fetch()
)

Template.message.helpers (
  time : -> screenUpdateDep.depend(); moment(@date).fromNow()
  room : -> @room_id
)

Template.search_bar.events (
  'submit #search_bar' : (evt, template) -> 
    evt.preventDefault()
    item = template.find('#srch-term')
    result = Messages.find({text: new RegExp(item)}).fetch()
    console.log(result)
    item.value = ''
    item.focus()
)
  
  
  