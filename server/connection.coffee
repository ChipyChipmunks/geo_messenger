Meteor.publish 'messages', -> Messages.find()
Meteor.publish 'topics', -> Topics.find()
