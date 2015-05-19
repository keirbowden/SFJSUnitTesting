({
	doInit : function(component, event, helper) {
		$A.get("e.c:JobInitEvent").fire();
	}
})