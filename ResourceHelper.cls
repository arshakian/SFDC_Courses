public class ResourceHelper {
	private static Decimal result {get; set;}
	private static Set<Id> relatedProjectIds {get; set;}
	private static List<Timelog_Entry__c> relatedTimelogs {get; set;}
	private static Map<Id, ResourcePermission__c> resourcePermissionByProjectId {get; set;}
	private static Map<Id, Decimal> overtimeByProjectIds {get; set;}


	public static String getOvertimeBenefitForResource(Resource__c resource){
		if (resource.isFired__c){
			throw new FiredResourceException('Resource: ' + resource + ' is fired.');
		}

		obtainRelatedTimelogs(resource);

		if (relatedTimelogs.isEmpty()){
			throw new TimelogsNotFoundException('Timelogs for this month cannot be found');
		}

		getRelatedProjectIds(resource);
		getOvertimeByProjectIds();

		updateRelatedResourcePermissions();

		return String.valueOf(result);

	}

	private static void obtainRelatedTimelogs(Resource__c resource){
		relatedTimelogs = [SELECT Id, Project__c, Resource__c FROM Timelog_Entry__c WHERE Resource__c =:resource.id AND CreatedDate > :System.now().addMonths(-1)];
	}

	private static void getRelatedProjectIds(Resource__c resource){
		relatedProjectIds = new Set<Id>();

		for (ResourcePermission__c rp : obtainResourcePermissions(resource)){
			relatedProjectIds.add(rp.Project__c);
		}
	}

	private static List<ResourcePermission__c> obtainResourcePermissions(Resource__c resource){
		resourcePermissionByProjectId = new Map<Id, ResourcePermission__c>();

		for (ResourcePermission__c rp : [SELECT Id, Project__c, Project__r.Overtime_Rate__c, Project__r.Contract_Time__c FROM ResourcePermission__c WHERE Resource__c = :resource.id]){
			resourcePermissionByProjectId.put(rp.Project__c, rp);
		}

		return resourcePermissionByProjectId.values();
	}

	private static void getOvertimeByProjectIds(){
		overtimeByProjectIds = new Map<Id, Decimal>();

		Map<Id, List<Timelog_Entry__c>> timelogsByProjectIds = summarizeTimelogsByProjectIds();

		for (Id projectId : timelogsByProjectIds.keySet()){
			Decimal totalSpentOnProject = getTotalSpentOnProject(timelogsByProjectIds.get(projectId));

			if(resourcePermissionByProjectId.get(projectId).Project__r.Contract_Time__c < totalSpentOnProject){
				overtimeByProjectIds.put(projectId, totalSpentOnProject - resourcePermissionByProjectId.get(projectId).Project__r.Contract_Time__c);
			}
			else{
				overtimeByProjectIds.put(projectId, 0.0);
			}

		}
	}

	private static Map<Id, List<Timelog_Entry__c>> summarizeTimelogsByProjectIds(){
		Map<Id, List<Timelog_Entry__c>> timelogsByProjectId = new Map<Id, List<Timelog_Entry__c>>();

		for (Timelog_Entry__c timelog : relatedTimelogs){
			if(timelogsByProjectId.containsKey(timelog.Project__c)){
				timelogsByProjectId.get(timelog.Project__c).add(timelog);
			}
			else{
				List<Timelog_Entry__c> projectTimelogs = new List<Timelog_Entry__c>();
				projectTimelogs.add(timelog);

				timelogsByProjectId.put(timelog.Project__c, projectTimelogs);
			}
		}

		return timelogsByProjectId;
	}

	private static Decimal getTotalSpentOnProject(List<Timelog_Entry__c> projectTimelogs){
		Decimal totalTimeSpent = 0.0;

		for (Timelog_Entry__c timelog : projectTimelogs){
			totalTimeSpent += timelog.Working_Hours__c;
		}

		return totalTimeSpent;
	}

	private static void updateRelatedResourcePermissions(){
		for (Id projectId : resourcePermissionByProjectId.keySet()){
			if (overtimeByProjectIds.get(projectId) != 0.0){
				resourcePermissionByProjectId.get(projectId).isOvertime__c = true;
				resourcePermissionByProjectId.get(projectId).Overtime_Hours__c = overtimeByProjectIds.get(projectId);

				result += resourcePermissionByProjectId.get(projectId).Project__r.Overtime_Rate__c * overtimeByProjectIds.get(projectId);
			}
		}
	}

	public class FiredResourceException extends Exception {}

	public class TimelogsNotFoundException extends Exception {}
}