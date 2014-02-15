<%
List<String> buildingTypes = locationDAO.retrieveAllBuildingTypes(locations);
double maxHeight = locationDAO.getMaximumHeight(locations);
double minHeight = locationDAO.getMinimumHeight(locations);
int maxYearBuilt = locationDAO.getMaximumYearBuilt(locations);
int minYearBuilt = locationDAO.getMinimumYearBuilt(locations);
int maxCapacity = locationDAO.getMaximumCapacity(locations);
int minCapacity = locationDAO.getMinimumCapacity(locations);
double maxPremium = locationDAO.getMaximumPremium(locations);
double minPremium = locationDAO.getMinimumPremium(locations);
double maxPropertyCoverageLimit =locationDAO.getMaximumPropertyCoverageLimit(locations);
double minPropertyCoverageLimit = locationDAO.getMinimumPropertyCoverageLimit(locations);
double maxLossCoverageLimit = locationDAO.getMaximumLossCoverageLimit(locations);
double minLossCoverageLimit = locationDAO.getMinimumLossCoverageLimit(locations);
ArrayList<String> foundationTypes = locationDAO.retrieveAllFoundationTypes(locations);

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
    <form name="search_location" method="post" action="search">
	
    <table>
    <tr>
    </tr>
        <tr>
            <td>
                Building Type:
            </td>
            <td>
               <%for (int i=0;i<buildingTypes.size();i++){%>
                <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>" checked/>
                <%=buildingTypes.get(i)%>
            <%}%>
            </td>
        </tr>
        <tr>
            <td>
                Building Name (containing):
            </td>
            <td>
                <input name="buildingName" type="text" placeholder="e.g. Shenton House">
            </td>
        </tr>
        <tr>
      		 <td>
                Building Height:
            </td>
            <td>
                Min:
                <select name="minHeight">
                <% double roundMaxHeight = (int)maxHeight/10*10 + 10;
                double roundMinHeight = (int)minHeight/10*10;
                for(double i=roundMinHeight;i<=roundMaxHeight; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxHeight">
                <%  for(double i=roundMinHeight;i<=roundMaxHeight; i+=10){ %>             
					<%if(i==roundMaxHeight){%>
					<option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
					<option value="<%=i%>"><%=i %></option>
					<%} 			
					} %>
                </select>  
            </td>
            </tr>
        <tr>
          <td>
                Year Built:
            </td>
            <td>
                From:
                <select name="minYearBuilt">
                <% int roundMinYearBuilt = minYearBuilt/10*10;
                  int roundMaxYearBuilt = maxYearBuilt/10*10+10;
                for(int i=roundMinYearBuilt;i<=roundMaxYearBuilt; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              To:
                <select name="maxYearBuilt">
                <%   for(int i=roundMinYearBuilt;i<=roundMaxYearBuilt; i+=10){ %>
                  <%if(i==roundMaxYearBuilt){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
        <tr>
          <td>
                Capacity:
            </td>
            <td>
                From:
                <select name="minCapacity">
                <%int roundMaxCapacity = maxCapacity/10*10+10;
                int roundMinCapacity = minCapacity/10*10;
                for(int i=roundMinCapacity;i<=roundMaxCapacity; i+=10){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              To:
                <select name="maxCapacity">
                <%   for(int i=roundMinCapacity;i<=roundMaxCapacity; i+=10){ %>
                  <%if(i==roundMaxCapacity){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
        <tr>
            <td>
                Premium:
            </td>
            <td>
                Min:
                <select name="minPremium">
                <% double roundMaxPremium = (int)maxPremium/100*100 + 100;
                double roundMinPremium = (int)minPremium/100*100;
                for(double i=roundMinPremium;i<=roundMaxPremium; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxPremium">
                <%  for(double i=roundMinPremium;i<=roundMaxPremium; i+=100){ %>
                  <%if(i==roundMaxPremium){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            
            </td>
        </tr>
        <tr>
            <td>
                Property Coverage Limit:
            </td>
            <td>
                Min:
                <select name="minPropertyCoverageLimit">
                <% double roundMaxPropertyCoverageLimit = (int)maxPropertyCoverageLimit/100*100 + 100;
                double roundMinPropertyCoverageLimit = (int)minPropertyCoverageLimit/100*100;
                for(double i=roundMinPropertyCoverageLimit;i<=roundMaxPropertyCoverageLimit; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxPropertyCoverageLimit">
                <%  for(double i=roundMinPropertyCoverageLimit;i<=roundMaxPropertyCoverageLimit; i+=100){ %>
                  <%if(i==roundMaxPropertyCoverageLimit){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            
            </td>
        </tr>
        <tr>
            <td>
                Loss Coverage Limit:
            </td>
            <td>
                Min:
                <select name="minLossCoverageLimit">
                <% double roundMaxLossCoverageLimit = (int)maxLossCoverageLimit/100*100 + 100;
                double roundMinLossCoverageLimit = (int)minLossCoverageLimit/100*100;
                for(double i=roundMinLossCoverageLimit;i<=roundMaxLossCoverageLimit; i+=100){ %>
                  <option value="<%=i%>"><%=i %></option>
                <%} %>
                </select>   
            </td>
            <td>
              Max:
                <select name="maxLossCoverageLimit">
                <%  for(double i=roundMinLossCoverageLimit;i<=roundMaxLossCoverageLimit; i+=100){ %>
                  <%if(i==roundMaxLossCoverageLimit){%>
						 <option value="<%=i%>" selected><%=i %></option>
					<%}else{%>
						<option value="<%=i%>"><%=i %></option>
					<%} 
                } %>
                </select>  
            </td>
        </tr>
         <tr>
            <td>
                Foundation Type:
            </td>
            <td>
               <%for (int i=0;i<foundationTypes.size();i++){%>
                <input name="foundationType" type="checkbox" value="<%=foundationTypes.get(i)%>" checked/>
                <%=foundationTypes.get(i)%>
            <%}%>

            </td>
        </tr>
        <tr>
            <td>
                Dataset:
            </td>
            <td>
               <%for (int i=0;i<userDatasetList.size();i++){%>
                <input name="datasets" type="checkbox" value="<%=userDatasetList.get(i)%>" checked/>
                <%=userDatasetList.get(i)%>
            <%}%>

            </td>
        </tr>
         <tr>
            <td>
                Remark (containing):
            </td>
            <td>
                <input name="remark" type="text" placeholder="e.g. pad foundation type">
            </td>
        </tr>
    </table>  
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="submit" class="btn btn-primary" value="Filter"/>
        <button type="reset" class="btn btn-default" value="Reset">Reset</button>
    </form>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
</body>
</html>