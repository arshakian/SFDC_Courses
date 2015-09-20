public class SOQLExecutorController {
	public String queryLabel  {get {return 'Enter your query:';} }
	

	public String query {get; set;}
	public String errorMessage {get; set;}
	public Boolean recordsFound {get; set;}
	public List<Account> searchResults {get; set;}
	public Integer searchResultSize {get {return searchResults.size();} set;}


	public SOQLExecutorController(){
		//as records initially wasn't found
		recordsFound = false;
		searchResults = new List<Account>();
	}


	public void executeQuery(){
		if (isQueryValid()){
			searchResults = Database.query(query);
			
			if (!searchResults.isEmpty()){
				recordsFound = true;
			}

			else{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Unable to find records for query : ' + query));
			}
			
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
		}
	}
	

	private Boolean isQueryValid(){
		if (queryIsNotEmpty() && queryStartsFromSELECT() && queryContainsFROMandlimitations()){
			return true;
		}
		return false;
	}

	private Boolean queryIsNotEmpty(){
		if(String.isNotEmpty(query)){
			return true;
		}

		errorMessage = 'Please, enter query';
		return false;
	}

	private Boolean queryStartsFromSELECT(){
		if (query.substring(0, 6).equalsIgnoreCase('Select')){
			return true;
		}

		errorMessage = 'Query starts from Select';
		return false;
	}

	private Boolean queryContainsFROMandlimitations(){
		if (query.containsIgnoreCase('FROM') && (query.containsIgnoreCase('WHERE') || query.containsIgnoreCase('LIMIT'))){
			return true;
		}

		errorMessage = 'Query should contain FROM and limitations (like, WHERE or LIMIT)';
		return false;
	}
}