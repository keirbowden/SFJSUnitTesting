({
	// displays the progress bar if the progress counter is > 0
	showProgress : function(component) {
		var spinner = component.find('spinner');
		var evt = spinner.get("e.toggle");
		evt.setParams({ isVisible : true });
		evt.fire();
	},
        
	// hides the progress bar if the progress counter is 0
	hideProgress : function (component) {
		var spinner = component.find('spinner');
		var evt = spinner.get("e.toggle");
		evt.setParams({ isVisible : false });
		evt.fire();
	},
        
	// sets up event handlers, skills checkboxes and recent jobs
	initialise : function (component) {
        var self=this;
		this.getSkills(component);
		this.getLatestJobs(component);
	},
        
	// clears the search terms and skills checkboxes and reverts the jobs list to the recent jobs view
	clearSearch : function(component) {
		$('[id^="skillcb_"]:checkbox:checked').removeAttr('checked');
		$('#searchterm').val('');
		this.getLatestJobs(component);
	},
        
	// executes a search based on the entered terms and selected skill sets
	doSearch : function(component) {
        console.log('In doSearch');
		this.showProgress(component);
		var term=$('#searchterm').val();
		var skills=[];
		$('[id^="skillcb_"]:checkbox:checked').each(function(i){
			skills.push($(this).val());
		});
        var skillsStr=skills.join();
		console.log('Term = ' + term);
		console.log('SkillsStr = ' + skillsStr);
        var action = component.get("c.SearchJobs");
		action.setParams({
			"searchStr": term,
            "skillsStr":skillsStr
		});
        
        var self = this;
        action.setCallback(this, function(response) {
            self.actionResponseHandler(response, self.renderJobs, component);
        });
    	$A.enqueueAction(action);
	},
    // get the latest jobs from the server
    getLatestJobs : function(component) {
        this.showProgress(component);
        var action = component.get("c.GetRecentJobs");
	    var self = this;
    	action.setCallback(this, function(response) {
            self.actionResponseHandler(response, self.renderJobs, component);
	    });
    	$A.enqueueAction(action);
    },
        
	// get the skills from the server
	getSkills : function (component) {
		this.showProgress(component);
        var action = component.get("c.GetSkills");
	    var self = this;
    	action.setCallback(this, function(response) {
            self.actionResponseHandler(response, self.renderSkills, component);
	    });
    	$A.enqueueAction(action);
	},
	renderJobs : function(wrappers, component) {
		$A.get("e.c:JobListEvent").
		        		setParams({jobWrappers: wrappers}).fire();
		
        if (0==wrappers.length)
		{
			alertify.error('No matching jobs found');
		}
	},
    renderSkills : function(skills, component) {
        component.set("v.skills", skills);
    },
	actionResponseHandler : function (response, cb, component) {
		var state = response.getState();
		if (state === "SUCCESS") 
		{
			var retVal=response.getReturnValue();
			console.log('Result = ' + JSON.stringify(retVal));
            cb(retVal, component);
		}
		else if (state === "ERROR")
		{
			var errors = response.getError();
			if (errors) 
			{
				$A.logf("Errors", errors);
				if (errors[0] && errors[0].message) 
				{
					$A.error("Error message: " + errors[0].message);
				}
			} 
			else 
			{
				$A.error("Unknown error");
			}
		}
        this.hideProgress(component);
	},
	// stack trace function - simply execute console.log(getStackTrace()); or similar - tested in chrome
    getStackTrace : function() {
  		var obj = {};
  		if (typeof Error.captureStackTrace == 'function')
  		{
	  		Error.captureStackTrace(obj, getStackTrace);
  			return obj.stack;
  		}
  		else
  		{
  			return 'Stack trace not supported';
  		}
	},
    //
	// Test methods
	// 
    runTests : function(component, event)
    {
        try
        {
	        QUnit.module('JobSearch'); 
	        this.testInitialise(component, event);
	        this.testClearSearch(component, event);
	        this.testDoSearch(component, event);
        }
        catch (e)
        {
            alert('Exception ' + e);
        }
    },
    testInitialise: function(component, event)
    {
        var self=this;
		QUnit.test( "Initialise", function( assert ) {
            // stub the methods that will be invoked
            var getSkillsStub = sinon.stub(self, 'getSkills');
            var getLatestJobsStub = sinon.stub(self, 'getLatestJobs');
            
            // execute the method under test
            self.initialise(component)
            
	 		// the methods should be executed exactly once
			assert.equal( getSkillsStub.callCount, 1, "getSkills called once");
			assert.equal( getLatestJobsStub.callCount, 1, "getLatestJobs called once");
            
            // remove the stubs and restore the original functions
			getSkillsStub.restore();
			getLatestJobsStub.restore();
		});
    },
    testClearSearch: function(component, event) {
        var self=this;
		QUnit.test( "Clear Search", function( assert ) {
            // stub the methods that will be invoked
            var getLatestJobsStub = sinon.stub(self, 'getLatestJobs');
			$('#searchterm').val('Unit Test');
            
            // execute the method under test
            self.clearSearch(component)
            
	 		// the methods should be executed exactly once
			assert.equal( getLatestJobsStub.callCount, 1, "getLatestJobs called once");
            
            // the search term should be cleared
            assert.equal( $('#searchterm').val(), '', "Search term cleared")
            
            // remove the stubs and restore the original functions
			getLatestJobsStub.restore();
		});
    },
    testDoSearch: function(component, event) {
        var self=this;
		QUnit.test( "Do Search", function( assert ) {
			// set up some skills
			var skills=
				[
					{ Name : 'Skill1' },
	                { Name : 'Skill2' }
				];
//			self.renderSkills(skills, self.component);

            // stub the methods that will be invoked
            var enqueueActionStub = sinon.stub($A, 'enqueueAction',
                                               function(action) {alert('Action = ' + JSON.stringify(action));});
            
            alert('Enqueue action = ' + $A.enqueueAction);
			$('#searchterm').val('Unit Test');
			$('#searchterm').val('Unit Test');
			$('[id^="skillcb_Skill1"]').prop('checked', true);           
            
            // execute the method under test
            self.doSearch(component)
            
	 		// the methods should be executed exactly once
			assert.equal( enqueueActionStub.callCount, 1, "enqueueAction called once");
            
            // remove the stubs and restore the original functions
			enqueueActionStub.restore();
		});

    }
    
})