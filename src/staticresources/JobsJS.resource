    var jobCtrl={
    	// progress counter - used to determine whether to show/hide the progress bar
    	progressCount  : 0,
    	
    	// method called to reset the controller to its initial state
    	reset : function() {
    		jobCtrl.progressCount=0;
    	},
    	
    	// displays the progress bar if the progress counter is > 0
    	showProgress : function() {
    		if (0==jobCtrl.progressCount) {
				$.blockUI({message: $('#progress')});
			}
    		jobCtrl.progressCount++;
    	},
    	
    	// hides the progress bar if the progress counter is 0
    	hideProgress : function () {
    		jobCtrl.progressCount--;
    		if (0==jobCtrl.progressCount) {
    			$.unblockUI();
    		}
    	},
    	
    	// sets up event handlers, skills checkboxes and recent jobs
    	initialise : function () {
			$('#searchbtn').on("click", jobCtrl.doSearch);
			$('#resetbtn').on("click", jobCtrl.clearSearch);
			jobCtrl.getLatestJobs();
			jobCtrl.getSkills();
		},
    	
    	// clears the search terms and skills checkboxes and reverts the jobs list to the recent jobs view
		clearSearch : function(ev) {
			$('[id^="skillcb_"]:checkbox:checked').removeAttr('checked');
			$('#searchterm').val('');
			jobCtrl.getLatestJobs();
		},
    	
    	// executes a search based on the entered terms and selected skill sets
		doSearch : function(ev) {
			jobCtrl.showProgress();
			var term=$('#searchterm').val();
			var skills=[];
			$('[id^="skillcb_"]:checkbox:checked').each(function(i){
		          skills.push($(this).val());
        		});
			console.log('Term = ' + term);
			console.log('Skills = ' + skills);
			JobsController.SearchJobs(term, skills, function(result, event) {jobCtrl.remoteCB(result, event, jobCtrl.handleJobs); }, {escape: false} );
		},
		
		// renders the HTML to display the supplied job wrappers in bootstrap panels
    	renderJobs : function(wrappers) {
    		var markup='';
			$.each(wrappers, function(idx, wrap) {
							markup+= '  <div class="row-fluid"> \n' +
									'    <div class="col-xs-12 fullwidth"> \n' +
									'      <div class="panel panel-primary"> \n' +
									'        <div class="panel-heading"> \n' +
									'          <h3 class="panel-title">' + wrap.job.Name + '</h3> \n' +
									'        </div> \n' +
									'        <div class="panel-body"> \n' +
									'          <div class="top-buffer table-responsive"> ' + wrap.job.Description__c + ' </div> \n' +
									'        </div> \n' +
									'        <div class="panel-footer"> \n';
							for (var idx=0; idx<wrap.skills.length; idx++)
							{
								markup+='<span class="label label-default">' + wrap.skills[idx].Name + '</span>\n ';
							}
									
							markup+= '       </div> \n' +
									'      </div> \n' + 
									'    </div> \n' +
									'  </div> \n' +
									'  <div class="fluid-row"> \n' +
									'    <div class="col-xs-12 top-buffer"> \n ' +
									'    </div> \n' +
									'  </div> \n';
    					});
    		$('#jobpanel').html(markup);
    	}, 

		// get the latest jobs from the server
		getLatestJobs : function() {
			jobCtrl.showProgress();
			JobsController.GetRecentJobs(function(result, event) {jobCtrl.remoteCB(result, event, jobCtrl.handleJobs); }, {escape: false} );
		},
		
		// callback function to handle the latest jobs returned from the server
		handleJobs : function (result) {
			jobCtrl.renderJobs(result);
		},
		
		// renders the HTML for the skills checkboxes
		renderSkills : function(skills) {
    		var markup='';
			$.each(skills, function(idx, skill) {
							markup+= '  <div class="col-xs-6">\n ' +
									'     <label class="checkbox-inline"> \n' +
									'       <input type="checkbox" id="skillcb_' + skill.Name + '" value="' + skill.Name + '">' + skill.Name + ' \n' +
									'     </label>\n' + 
									'   </div>\n '; 
    					});
    		$('#searchskills').html(markup);
		},
		
		// get the skills from the server
		getSkills : function () {
			jobCtrl.showProgress();
			JobsController.GetSkills(function(result, event) {jobCtrl.remoteCB(result, event, jobCtrl.handleSkills); } );
		},
		
		// callback function to handle the skills returned from the server
		handleSkills : function (result) {
			jobCtrl.renderSkills(result);
		},
		
		// generic JavaScript remoting callback function - checks for errors and if there are none, executes the supplied callback
		remoteCB : function (result, event, cb) {
			console.log('Result = ' + JSON.stringify(result)); 
			console.log('Event = ' + JSON.stringify(event));
			console.log('CB = ' + cb); 
			if (event.status)
			{ 
				cb(result);
			}
			else if (event.type === 'exception')
			{
				alert('Exception in Remote Action\n\nMessage: ' + event.message + '\n\nWhere: ' + event.where);
			}
			else
			{
				alert('Something else went wrong');
			}
			jobCtrl.hideProgress();
		}		
    };