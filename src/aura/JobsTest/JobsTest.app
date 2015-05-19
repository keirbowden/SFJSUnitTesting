<aura:application >
    <aura:registerEvent name="RunTestsEvent" type="c:RunTestsEvent" />
    <ltng:require scripts="/resource/JQuery_2_1_3,
                             /resource/qunitJS_1_18_0,
                             /resource/sinon_1_14_1"
			    	styles="/resource/qunitCSS_1_18_0"
	    			afterScriptsLoaded="{!c.doInit}"/>

    
    <div id="qunit"></div>
    <div id="qunit-fixture">
    </div>
    <div style="display:none">
	    <c:JobList />
	    <c:JobSearch />
    </div>
</aura:application>