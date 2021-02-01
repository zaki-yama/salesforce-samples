({
    doInit: function(component, event, helper) {
      var action = component.get('c.findAll');
      action.setCallback(this, function(a) {
        component.set('v.accounts', a.getReturnValue());
        var event = $A.get('e.c:AccountsLoaded');
        event.setParams({'accounts': a.getReturnValue()});
        event.fire();
      });
      $A.enqueueAction(action);
    }
})
