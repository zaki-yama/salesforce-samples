({
  send: function(component, event, helper) {
    var messageEvent = component.getEvent('messageEvent');
    var text = event.source.get('v.label');
    messageEvent.setParams({
      'text': text
    }).fire();
  },
  answer: function(component, event, helper) {
    var text = event.getParam('text');
    component.set('v.myText', text);
  }
})
