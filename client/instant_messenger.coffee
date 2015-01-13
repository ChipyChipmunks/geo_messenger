Meteor.subscribe("messages")

Template.textInput.events(
  'submit #ourForm': (evt, template) -> 
    console.log('input' ,text)
    console.log(Meteor.user().emails[0].address);
    input = template.find('#messagebox')
    text = input.value 
    Messages.insert (
      text: text
      user: Meteor.user()._id
      email: Meteor.user().emails[0].address
      date: new Date()
    )
    input.value=''
    input.focus()
    false
)



Template.messages.helpers ( 
  messages : -> Messages.find({}).fetch()
)

Template.message.helpers ( 
  time : -> moment(@date).fromNow()
)