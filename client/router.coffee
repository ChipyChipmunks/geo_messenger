Router.configure layoutTemplate: 'layout'

Router.route '/', -> @render('rooms')
Router.route '/rooms/:_id', -> @render('room', {data: room_id: @params._id})
#Router.route '/users/:_id', -> @render('user', {data: user_id: @params._id})
