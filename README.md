# SFJSUnitTesting
JavaScript Unit Testing for Salesforce - Visualforce and Lightning components

## Installation Instructions
1. Sign up for a new developer edition
2. Enable Lightning components and my domain
3. Clone this repository into your Eclipse workspace :
  
  git clone https://github.com/keirbowden/SFJSUnitTesting.git *&lt;project_name&gt;*
  
  where *&lt;project_name&gt;* is the name you would like the project to have in Eclipse, and will be the directory name
4. Create a new project in Eclipse, using the _<project>_ value from above as the name, and the user id and password for your new dev org as the credentials. **Select 'none' for the metadata components.**

  Once the project has been created you should see all of the metadata from the cloned repository
  
5. Right click the 'src' folder and select 'Save to Server', then wait a short while.
6. Finally, set up some Skills, Job Postings and Job Skills and try out the pages

Unfortunately you can't deploy Lightning components in this way, so you'll need to use a tool like the Force CLI or Force.com Migration Tool (ant) for that. 
