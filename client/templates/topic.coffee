Meteor.subscribe("messages")
Meteor.subscribe("logs")

screenUpdateDep = new Tracker.Dependency;

Meteor.setInterval((-> screenUpdateDep.changed()), 30000)

Template.textInput.events(
  'submit #insert_messages_form': (evt, template) -> 
    evt.preventDefault()
    input = template.find('text')
    text = input.value 
  
    Messages.insert (
      message: text
      creation_date: new Date()
      owner: Meteor.user()._id
      owner_email: Meteor.user().emails[0].address
    )

Messages.insert new_message, () ->
  $('a[href="#Messages"]').click()
  $(".tab-content").scrollTop 1000000000000000000
  return

  input.value = ''
  input.focus()
  return
)

position = ->
    pos = Geolocation.currentLocation()
    if pos == null
      pos = [-41.2889, 174.7772] 
     else
        pos = [pos.coords.latitude, pos.coords.longitude]
        pos

Template.topic.helpers(
  name : -> topic = Topics.findOne({_id:(@topic_id)}); topic && topic.name
)

Template.message.events(
  'click .trash' : -> (Messages.remove(this._id))
  'click .arrow' : -> console.log('Its working')
  'click .message' : -> console.log(this) 
  'click .clipboard' : -> 
)

Template.messages.helpers ( 
  messages : -> Messages.find({topic_id: @topic_id},{sort: { date: 1 }}).fetch()
)

Template.message.helpers (
  time : -> screenUpdateDep.depend(); moment(@date).fromNow()
  topic : -> @topic_id
)


