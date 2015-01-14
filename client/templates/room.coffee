Meteor.subscribe("messages")

screenUpdateDep = new Tracker.Dependency;

Meteor.setInterval((-> screenUpdateDep.changed()), 30000)


Template.textInput.events(
  'submit #ourForm': (evt, template) -> 
    console.log(Meteor.user().emails[0].address);
    input = template.find('#messagebox')
    text = input.value 
    Messages.insert (
      room_id: @room_id
      text: text
      user: Meteor.user()._id
      email: Meteor.user().emails[0].address
      date: new Date()
    )
    input.value=''
    input.focus()
    false
)

Template.room.helpers(
  name : -> 'name'
)

Template.message.events(
  'click .trash' : -> (Messages.remove(this._id))
)

Template.messages.helpers ( 
  messages : -> Messages.find({room_id:@room_id}).fetch()
)

Template.message.helpers (
#  time : -> moment(@date).fromNow()
  time : -> screenUpdateDep.depend(); moment(@date).fromNow()
  room : -> @room_id
)