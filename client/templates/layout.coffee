Template.layout_search_bar.events (
  'submit #search_bar' : (evt, template) -> 
    
    item = template.find('#srch-term')
  
    result = Messages.find({text: new RegExp(item)}).fetch()
    console.log(result)
  
    #results = Messages.find({room_id:@room_id}, {item:@text}).fetch()
    #console.log(results)
  
    false
)