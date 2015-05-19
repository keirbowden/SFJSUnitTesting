{
doAction : function(component) {
var inputCmp = component.find("inputCmp");
var value = inputCmp.get("v.value");
// is input numeric?
if (isNaN(value)) {
// set error
inputCmp.setValid("v.value", false);
inputCmp.addErrors("v.value", [{message:"Input not a number: " + value}]);
} else {
// clear error
inputCmp.setValid("v.value", true);
}
}
}