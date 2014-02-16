<!-- JAVA INITIALIZATION -->
<%
int a = 12345;
User user = (User) session.getAttribute("authenticated.user");
String username = user.getUsername();
String errorMsg="";
HashMap<String,ArrayList<String>> locationErrors = (HashMap<String,ArrayList<String>>)request.getAttribute("locationErrors");
ArrayList<String> fileErrors = (ArrayList<String>)request.getAttribute("fileErrors");
if(locationErrors!=null){
    Iterator<String> iterator1 = locationErrors.keySet().iterator();
    while(iterator1.hasNext()){
        String errorLine = iterator1.next();
        errorMsg += errorLine+": ";
        ArrayList<String> errorStr = locationErrors.get(errorLine);
        for(int i=0;i<errorStr.size();i++){
            if(i==errorStr.size()){
            	errorMsg += errorStr.get(i);
            }else{
            	errorMsg += errorStr.get(i)+ ", ";
            }
        }
        errorMsg += "</br>";

    }
}
if(fileErrors!=null){
    for(int i=0;i<fileErrors.size();i++){
        errorMsg += fileErrors.get(i) + ": invalid data file";
        errorMsg +="</br>";
    }
}
LocationDAO locationDAO = new LocationDAO();
List<Location> locations = new ArrayList<Location>();
List<Location> searchResults = (List<Location>)session.getAttribute("locationSearchResult");
if(searchResults==null || searchResults.isEmpty()){
   //ADD ERROR THAT SAYS NO RESULTS FOUND
 // if (locationDAO.retrieveByUsername(username) != null ) {
	 locations.addAll(locationDAO.retrieveByUsername(username));
  //}
  //if (locationDAO.retrieveByUsername("admin") != null) {
	 locations.addAll(locationDAO.retrieveByUsername("admin"));
	//} 
}
else {
  locations = searchResults;
}
ArrayList<String> userDatasetList = new ArrayList<String>();
if (locationDAO.retrieveByUsername(username) != null ) {
userDatasetList = locationDAO.getDatasetListByUsername(username);
}
userDatasetList.add("system location dataset");
HashMap<String,Integer> datasetMap = new HashMap<String,Integer>();
for(int i=0;i<userDatasetList.size();i++){
	if(!datasetMap.containsKey(userDatasetList.get(i))){
		datasetMap.put(userDatasetList.get(i).toString(),i+1);
	}
}
%>

