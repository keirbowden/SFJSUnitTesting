<aura:application >
    <ltng:require scripts="/resource/JQuery_2_1_3,
                           /resource/Bootstrap_3_3_2/bootstrap-3.3.2-dist/js/bootstrap.min.js,
                           /resource/alertify_0_3_11/alertify.js-0.3.11/lib/alertify.min.js"
			    styles="/resource/Bootstrap_3_3_2/bootstrap-3.3.2-dist/css/bootstrap.min.css,
						/resource/Bootstrap_3_3_2/bootstrap-3.3.2-dist/css/bootstrap-theme.min.css,
			            /resource/alertify_0_3_11/alertify.js-0.3.11/themes/alertify.core.css,
                        /resource/alertify_0_3_11/alertify.js-0.3.11/themes/alertify.bootstrap.css"
			    afterScriptsLoaded="{!c.doInit}"/>
    
    <aura:registerEvent name="JobInitEvent" type="c:JobInitEvent" />
    
      <style>
		.top-buffer { 
			margin-top:20px; 
		}
		.fullwidth {
			margin-left:0;
			margin-right:0;
			padding-left:0;
			padding-right:0;
		}
		.hidden-toggle {
			display:none;
		}
		.navbar-default {
			background-color: #fe5000;
			color: #fff;
		}
		.nav.nav-center {
			margin:auto;
    		float:none;
			color: #fff;
		}
		.nav-logo-small {
			margin: auto; 
			display:block; 
			height:2.5em; 
			width:2.647em;
			margin-top: 0.6em;
		}
		.nav-logo-large {
			margin-left: 55%; 
			display:block; 
			height:2em; 
			width:8.823em;
			margin-top: 0.7em;
		}
		.sm-container {
			margin-top: 0.8em;
			float:left;
		}
		.sm-icon {
			width:1.75em;
			height:1.75em;
			margin-left: 0.5em;
		}
		
		@media ( min-width: 48em ) {
			div.navbar-header {
				width:70%;
			}
		}

		@media ( min-width: 64em ) {
			div.navbar-header {
				width:85%;
			}
		}
    </style>
    
	<nav id="navbar" class="navbar navbar-inverse" role="navigation">
  	  <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
            <img class="hidden-xs nav-logo-large" src="/resource/BGLogo" />
            <img class="nav-logo-small visible-xs" src="/resource/BGIcon" />
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="{! '#' + 'search'}" class="menu-trigger hidden-md hidden-lg">Search</a>
            </li>
            <li>
                <a href="/apex/JobLinks" target="_blank" class="menu-trigger">Links</a>
            </li>
          </ul>
        </div><!-- /.navbar-collapse -->
     </div> !-- /.container-fluid -->
  </nav>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="col-xs-12 col-md-9">
          <c:JobList />
      </div>
        <a id="_search"></a>
      <div class="col-md-3 col-xs-12">
          <c:JobSearch />
      </div>

    </div>
     </div>
     
	    <div class="opaque"/>

    	<div id="progress" style="display:none">
          <div style="margin-bottom:0px" class="progress progress-striped active">
            <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
            </div>
  	      </div>
  	    </div>
       <div id="progressold" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%; display:none">
         <span class="sr-only">45% Complete</span>
       </div>
</aura:application>