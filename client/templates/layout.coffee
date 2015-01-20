Template.layout_search_bar.events (
  'submit #search_bar' : (evt, template) -> 
    
    item = template.find('#srch-term')
    console.log(item.value)
  
    false
)