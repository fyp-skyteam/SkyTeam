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
ArrayList<String> masonryTypes = locationDAO.retrieveAllMasonryTypes(locations);
ArrayList<String> roofTypes = locationDAO.retrieveAllRoofTypes(locations);
%>
<form name="search_location" method="post" action="search">
    <div class="row">
        <div class="col-md-5">
            Building Type:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<buildingTypes.size();i++){%>
            <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>" checked/>
            <%=buildingTypes.get(i)%>
        <%}%>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Building Name (containing):
        </div>
		<div class="col-md-7">
            <input name="buildingName" type="text" placeholder="e.g. Shenton House">
        </div>
    </div>
    <br/>
    
    <div class="row">
  		 <div class="col-md-5">
            Building Height:
        </div>
        <div class="col-md-7">
        	<div class="row">
	        	<div class="col-md-2">
	        		<b><%=(int)minHeight/10*10%></b>
	        	</div>
	        	<div class="col-md-7">
	        		 <input id="slideBuildingHeight" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minHeight/10*10%>" data-slider-max="<%=(int)maxHeight/10*10 + 10 %>" data-slider-step="10" data-slider-value="[<%=(int)minHeight/10*10%>,<%=(int)maxHeight/10*10 + 10 %>]">
	        	</div>
		        <div class="col-md-3" style="text-align:right;">
		             <b><%=(int)maxHeight/10*10 + 10 %></b>
		        </div>
	            <input type="hidden" id="minHeight" name="minHeight" value="<%=(int)minHeight/10*10%>">
				<input type="hidden" id="maxHeight" name="maxHeight" value="<%=(int)maxHeight/10*10 + 10 %>">
        	</div>
        </div>    
    </div>
    <br/>
    
    <div class="row">
      <div class="col-md-5">
            Year Built:
      </div>
      <div class="col-md-7">
        	<div class="row">
        		<div class="col-md-2">
        			<b><%=minYearBuilt/10*10%></b>
        		</div>
        		<div class="col-md-7">
        			<input id="slideYearBuilt" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=minYearBuilt/10*10%>" data-slider-max="<%=maxYearBuilt/10*10+10 %>" data-slider-step="10" data-slider-value="[<%=minYearBuilt/10*10%>,<%=maxYearBuilt/10*10+10 %>]">
        		</div>
        		<div class="col-md-3" style="text-align:right;">
        			<b><%=maxYearBuilt/10*10+10 %></b>
        		</div>
        	</div>
        	<input type="hidden" id="minYearBuilt" name="minYearBuilt" value="<%=minYearBuilt/10*10%>">
			<input type="hidden" id="maxYearBuilt" name="maxYearBuilt" value="<%=maxYearBuilt/10*10+10 %>">
		</div>
    </div>
   <br/>
    <div class="row">
      <div class="col-md-5">
            Capacity:
        </div>
       <div class="col-md-7">
       	<div class="row">
       	  <div class="col-md-2">
            <b><%=minCapacity/10*10%></b>
          </div><div class="col-md-7">
        	<input id="slideCapacity" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=minCapacity/10*10%>" data-slider-max="<%=maxCapacity/10*10+10 %>" data-slider-step="10" data-slider-value="[<%=minCapacity/10*10%>,<%=maxCapacity/10*10+10 %>]">
          </div><div class="col-md-3" style="text-align:right;">  
            <b><%=maxCapacity/10*10+10 %></b>
          </div>
         </div>
            <input type="hidden" id="minCapacity" name="minCapacity" value="<%=minCapacity/10*10%>">
			<input type="hidden" id="maxCapacity" name="maxCapacity" value="<%=maxCapacity/10*10+10%>">
		 </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Premium:
       </div>
       <div class="col-md-7">
       		<div class="row">
       		 <div class="col-md-2">
	            <b><%=(int)minPremium/100*100%></b>
	         </div><div class="col-md-7">
	        	<input id="slidePremium" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minPremium/100*100%>" data-slider-max="<%=(int)maxPremium/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minPremium/100*100%>,<%=(int)maxPremium/100*100 + 100 %>]">
	         </div><div class="col-md-3" style="text-align:right;">   
	            <b><%=(int)maxPremium/100*100 + 100 %></b>
	         </div>
	        </div>
	            <input type="hidden" id="minPremium" name="minPremium" value="<%=(int)minPremium/100*100%>">
				<input type="hidden" id="maxPremium" name="maxPremium" value="<%=(int)maxPremium/100*100 + 100%>">
	    </div>
	</div>
	<br/>
    <div class="row">
        <div class="col-md-5">
            Property Coverage Limit:
        </div>
        <div class="col-md-7">
          <div class="row">
           <div class="col-md-2">
            <b><%=(int)minPropertyCoverageLimit/100*100%></b>
           </div><div class="col-md-7">
        	<input id="slidePropertyCoverageLimit" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minPropertyCoverageLimit/100*100%>" data-slider-max="<%=(int)maxPropertyCoverageLimit/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minPropertyCoverageLimit/100*100%>,<%=(int)maxPropertyCoverageLimit/100*100 + 100 %>]">
           </div><div class="col-md-3" style="text-align:right;"> 
            <b><%=(int)maxPropertyCoverageLimit/100*100 + 100 %></b>
           </div>
          </div>
            <input type="hidden" id="minPropertyCoverageLimit" name="minPropertyCoverageLimit" value="<%=(int)minPropertyCoverageLimit/100*100%>">
			<input type="hidden" id="maxPropertyCoverageLimit" name="maxPropertyCoverageLimit" value="<%=(int)maxPropertyCoverageLimit/100*100 + 100%>">
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Loss Coverage Limit:
        </div>
        <div class="col-md-7">
          <div class="row">
           <div class="col-md-2">
            <b><%=(int)minLossCoverageLimit/100*100%></b>
           </div><div class="col-md-7">
        	<input id="slideLossCoverageLimit" type="text" class="span2" value=""  style="width:180px;" data-slider-min="<%=(int)minLossCoverageLimit/100*100%>" data-slider-max="<%=(int)maxLossCoverageLimit/100*100 + 100 %>" data-slider-step="100" data-slider-value="[<%=(int)minLossCoverageLimit/100*100%>,<%=(int)maxLossCoverageLimit/100*100 + 100 %>]">
           </div><div class="col-md-3" style="text-align:right;">
			<b><%=(int)maxLossCoverageLimit/100*100 + 100 %></b>
		   </div>
		  </div> 
            <input type="hidden" id="minLossCoverageLimit" name="minLossCoverageLimit" value="<%=(int)minLossCoverageLimit/100*100%>">
			<input type="hidden" id="maxLossCoverageLimit" name="maxLossCoverageLimit" value="<%=(int)maxLossCoverageLimit/100*100 + 100%>">
         </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Foundation Type:
        </div>
       <div class="col-md-7">
           <%for (int i=0;i<foundationTypes.size();i++){%>
            <input name="foundationType" type="checkbox" value="<%=foundationTypes.get(i)%>" checked/>
            <%=foundationTypes.get(i)%>
        <%}%>
       </div>
    </div>
    <br/>
     <div class="row">
        <div class="col-md-5">
            Masonry Type:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<masonryTypes.size();i++){%>
            <input name="masonryType" type="checkbox" value="<%=masonryTypes.get(i)%>" checked/>
            <%=masonryTypes.get(i)%>
        <%}%>

        </div>
    </div>
     <div class="row">
        <div class="col-md-5">
            Roof Type:
         </div>
        <div class="col-md-7">
           <%for (int i=0;i<roofTypes.size();i++){%>
            <input name="roofType" type="checkbox" value="<%=roofTypes.get(i)%>" checked/>
            <%=roofTypes.get(i)%>
        <%}%>

        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Dataset:
        </div>
        <div class="col-md-7">
           <%for (int i=0;i<userDatasetList.size();i++){%>
            <input name="datasets" type="checkbox" value="<%=userDatasetList.get(i)%>" checked/>
            <%=userDatasetList.get(i)%>
        <%}%>

        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-5">
            Remark (containing):
        </div>
        <div class="col-md-7">
            <input name="remark" type="text" placeholder="e.g. pad foundation type">
        </div>
    </div>
    <br/>
    <input type="hidden" name="username" value="<%=username%>"/>
    <input type="submit" class="btn btn-primary" value="Filter"/>
    <button type="reset" class="btn btn-default" value="Reset">Reset</button>
</form>
