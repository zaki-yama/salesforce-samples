({
  answer: function(component, event, handler) {
    var text = event.getParam('text');
    component.set('v.myText', text);
  }
})
