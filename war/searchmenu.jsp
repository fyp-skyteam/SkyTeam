<%@page import="entity.*"%>
<%@include file="protect.jsp"%>

<%@page import="dao.*"%>
<%@page import="java.util.*"%>

<%
LocationDAO locationDAO = new LocationDAO();
List<String> buildingTypes = locationDAO.retrieveAllBuildingTypes();
double minHeight = locationDAO.getMinimumHeight();
double maxHeight = locationDAO.getMaximumHeight();
%>
<html>
    <form name="search_location" method="post" action="search">
    <table>
        <tr>
            <td>
                Building Type:
            </td>
            <td>
               <%for (int i=0;i<buildingTypes.size();i++){%>
                <input name="buildingType" type="checkbox" value="<%=buildingTypes.get(i)%>"/>
                <%=buildingTypes.get(i)%>
            <%}%>
            </td>
        </tr>
        <tr>
            <td>
                Building Name:
            </td>
            <td>
                <input name="buildingName" type="text" value="Any">
            </td>
        </tr>
        
    </table>  
            <input type="submit" value="Search"/>
    </form>
    
</html>