
Meteor.subscribe("messages")
Meteor.subscribe("logs")

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
    if Topics.findOne({_id:@topic_id}) != undefined
      new_message =
        topic_id: @topic_id
        text: text
        user: Meteor.user()._id
        email: Meteor.user().emails[0].address
        position: position()
        date: new Date()

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
		

#topic_name : -> topic = topics.findOne({_id:(@topic_id)}); topic && topic.name 

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

  
  