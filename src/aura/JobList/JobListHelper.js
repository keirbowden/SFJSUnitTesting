({
    // function to receive a list of jobs and set into the appropriate component
    // attribute
	receiveJobs : function(component, event) {
        var jobsList=event.getParam("jobWrappers");
        component.set("v.jobWrappers", jobsList);
    },
    //
	// Test methods
	// 
    runTests : function(component, event)
    {
        this.testReceiveJobs(component, event);
    },
    //
    // Test the receive jobs functionality
    //
    testReceiveJobs : function(component, event)
    {
        QUnit.module('JobList : ReceiveJobs'); 

        var self=this;
		QUnit.test( "Receive Jobs (methods)", function( assert ) {
            // stub the methods that will be invoked
            var evGetParamStub = sinon.stub(event, 'getParam');
            var compSetStub = sinon.stub(component, 'set');
            
            // execute the method under test
            self.receiveJobs(component, event)
            
	 		// the methods should be executed exactly once
			assert.equal( evGetParamStub.callCount, 1, "Event getParam called once");
			assert.equal( compSetStub.callCount, 1, "Component set called once");
            
            // remove the stubs and restore the original functions
			evGetParamStub.restore();
			compSetStub.restore();
		});

		QUnit.test( "Receive Jobs (attribute)", function( assert ) {
			// set up test job data
			var testJobs = 
				[{
		        	job : {
		        		Name : 'Test',
			    		Description__c : 'Desc'
			        	},
			    	skills : [
		    	      	{ Name : "Java" }
					   ]
				}];
            
            // stub the event getParam to return the test job data
            var evGetParamStub = sinon.stub(event, 'getParam', function (name)
                                            {
                                                return testJobs;
                                            });
            
            // execute method under test
            self.receiveJobs(component, event)
            
			// verify the component attribute is now set to the test job data
			assert.equal( component.get("v.jobWrappers"), testJobs, "Attributes set");
            
           evGetParamStub.restore();
		});
    }
})