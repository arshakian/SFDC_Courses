@isTest
public class ResourceHelperTests{
/*
	@isTest
	static void checkIfResourceIsFired_ValidExceptionShouldBeThrown(){
		Resource__c firedGuy = createResource();
		firedGuy.isFired__c = true;

		insert firedGuy;

		Test.startTest();

			try{
				ResourceHelper.getOvertimeBenefitForResource(firedGuy);	
			}
			catch(Exception firedException){
				System.assert(firedException.getMessage().contains('Resource: ' + 'Test Resource' + ' is fired.'));
			}

		Test.stopTest();
	}

	@isTest 
	static void checkIfResourceHaveNoTimelog_TimelogsNotFoundExceptionWillBeThrown(){
		Resource__c passiveGuy = createResource();

		insert passiveGuy;

		Test.startTest();

			try{
				ResourceHelper.getOvertimeBenefitForResource(passiveGuy);	
			}
			catch(Exception firedException){
				System.assert(firedException.getMessage().contains('Timelogs for this month cannot be found'));
			}

		Test.stopTest();
	}

	@isTest
	static void checkIfResourceHadNotOvertimedDuringThisMonth_BenefitIsEqualToNull(){
		Resource__c sampleGuy = createResource();
		insert sampleGuy;

		Project__c sampleProject = createProject();
		sampleProject.Contract_Time__c = 10;
		sampleProject.Overtime_Rate__c = 10.0;
		insert sampleProject;

		Project_Involvement__c sampleGuyCanWorkOnProject = createPI(sampleGuy, sampleProject);
		insert sampleGuyCanWorkOnProject;

		Timelog__c onlyOneTimelog = createTimelog(sampleGuy, sampleProject);
		insert onlyOneTimelog;

		Test.startTest();
			String result = ResourceHelper.getOvertimeBenefitForResource(sampleGuy);	
			
			System.assertEquals('0.0', result, 'No overtime benefit should be granted for resource');
		Test.stopTest();
	}

	@isTest
	static void checkIfResourceHadNotOvertimedDuringThisMonth_BenefitIsEqualToNull_ForBulk(){
		Resource__c sampleGuy = createResource();
		insert sampleGuy;

		Project__c sampleProject = createProject();
		sampleProject.Contract_Time__c = 100;
		sampleProject.Overtime_Rate__c = 10.0;
		insert sampleProject;

		Project_Involvement__c sampleGuyCanWorkOnProject = createPI(sampleGuy, sampleProject);
		insert sampleGuyCanWorkOnProject;

		createTimelogsForResource(99, sampleGuy, sampleProject);

		Test.startTest();
			String result = ResourceHelper.getOvertimeBenefitForResource(sampleGuy);	
			
			System.assertEquals('0.0', result, 'No overtime benefit should be granted for resource');
		Test.stopTest();
	}

	@isTest
	static void checkIfOvertimeBenefitIsCalculatedCorrectly(){
		Resource__c sampleGuy = createResource();
		insert sampleGuy;

		Project__c sampleProject = createProject();
		sampleProject.Contract_Time__c = 10;
		sampleProject.Overtime_Rate__c = 10.0;
		insert sampleProject;

		Project_Involvement__c sampleGuyCanWorkOnProject = createPI(sampleGuy, sampleProject);
		insert sampleGuyCanWorkOnProject;

		Timelog__c onlyOneTimelog = createTimelog(sampleGuy, sampleProject);
		onlyOneTimelog.Working_Hours__c = 100;
		insert onlyOneTimelog;

		Test.startTest();
			String result = ResourceHelper.getOvertimeBenefitForResource(sampleGuy);	
			
			System.assertEquals('900.0', result, '90h overtimed for 10$. Should be 900$');
		Test.stopTest();
	}

	@isTest
	static void checkIfOvertimeBenefitIsCalculatedCorrectly_ForMultipleTimelogs(){
		Resource__c sampleGuy = createResource();
		insert sampleGuy;

		Project__c sampleProject = createProject();
		sampleProject.Contract_Time__c = 10;
		sampleProject.Overtime_Rate__c = 10.0;
		insert sampleProject;

		Project_Involvement__c sampleGuyCanWorkOnProject = createPI(sampleGuy, sampleProject);
		insert sampleGuyCanWorkOnProject;

		createTimelogsForResource(1000, sampleGuy, sampleProject);

		Test.startTest();
			String result = ResourceHelper.getOvertimeBenefitForResource(sampleGuy);	
			
			System.assertEquals('9900.0', result, '990h overtimed for 10$. Should be 9000$');
		Test.stopTest();
	}
	
	static Resource__c createResource(){
		Resource__c resource = new Resource__c();
		resource.Name = 'Test Resource';
		resource.Type__c = 'Salesforce Developer';
		resource.Level__c = 'Senior';

		return resource;
	} 

	static Project__c createProject(){
		Project__c project = new Project__c();
		project.Name = 'Test Project';
		project.Contract_Time__c = 600;
		project.Overtime_Rate__c = 10;

		return project;
	}

	static Project_Involvement__c createPI(Resource__c r, Project__c p){
		Project_Involvement__c projectInvolvment = new Project_Involvement__c();
		projectInvolvment.Name = 'R can work on P';
		projectInvolvment.Resource__c = r.Id;
		projectInvolvment.Project__c = p.Id;
		projectInvolvment.Overtime_Hours__c = 0.0;

		return projectInvolvment;
	}

	static Timelog__c createTimelog(Resource__c r, Project__c p){
		Timelog__c timelog = new Timelog__c();
		timelog.Name = 'Test Timelog';
		timelog.Resource__c = r.Id;
		timelog.Project__c = p.Id;
		timelog.Date__c = Date.today();
		timelog.Working_Hours__c = 1.0;
		timelog.Comments__c = 'Today I Worked.';

		return timelog;
	}

	static void createTimelogsForResource(Integer size, Resource__c resource, Project__c project){
		List<Timelog__c> timelogs = new List<Timelog__c>();		

		for(Integer i = 0; i < size; i++){
			timelogs.add(createTimelog(resource, project));
		}

		insert timelogs;
	}
*/
}