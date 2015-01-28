Router.configure layoutTemplate: 'layout'

Router.route '/', -> @render('topics')
Router.route '/topics/:_id', -> @render('topic', {data: topic_id: @params._id})
