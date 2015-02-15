Meteor.subscribe("topics")

Template.topics.helpers ( 
  topic_list : -> Topics.find({}, { sort: { name: 1 }}).fetch()
)

Template.topics.events(
  'submit #insert_topics_form': (evt, template) -> 
    evt.preventDefault()
    input = template.find('name')
    text = input.value 
  
    Topics.insert (
      name: text
      creation_date: new Date()
      owner: Meteor.user()._id
      owner_email: Meteor.user().emails[0].address
    )
  
    input.value=''
    input.focus()
  
  'click .trash': -> 
    Topics.remove(@_id)
)