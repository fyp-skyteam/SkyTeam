package servlet;

import entity.*;  
import dao.*;

import java.io.*; 
import java.util.*;
import java.util.zip.*;

import javax.servlet.*;
import javax.servlet.http.*; 

import org.apache.commons.fileupload.*; 
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.util.Streams;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;

public class GetDataServlet extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("test");
		
		 try {

		      URL url = new URL("https://www.googleapis.com/mapsengine/v1/tables/14137585153106784136-16071188762309719429/features?maxResults=500&version=published&key=AIzaSyDGlrJF02Tw7kQb_Uj2boG3lDv5CvBFH5Q");
		      HttpURLConnection connection = (HttpURLConnection)url.openConnection();
		      connection.setRequestMethod("GET");
		      connection.setDoOutput(true);
		      connection.connect();

		      BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));

		      // Deserialize.
		      GsonBuilder builder = new GsonBuilder();
		      builder.registerTypeAdapter(Geometry.class, new GeometryDeserializer());
		      Gson gson = builder.create();

		     FeaturesListResponse map = gson.fromJson(reader, FeaturesListResponse.class);
		      for(int i=0;i<map.features.length;i++){
		    	  PointGeometry g = (PointGeometry)map.features[i].geometry;
			      out.println(g.coordinates[0] + ", " + g.coordinates[1]);
			      out.println((String)(map.features[i].properties.get("Name")));
			      out.println((int)(map.features[i].properties.get("Population")));
			      out.println((String)(map.features[i].properties.get("gx_id")));	
			      out.println("</br>");
		      }
		     
		    } catch (IOException e) {
		      out.println(e.getMessage());
		    } catch (Throwable t) {
		      t.printStackTrace();
		    }		
	}
	
	 public static class FeaturesListResponse {
	    public Feature[] features;
	 }

	 public static class Feature {
		 public Geometry geometry;
		 public Map properties;
	 }

	 public static class Geometry {
	 }

	 public static class PointGeometry extends Geometry {
	    public double[] coordinates;
	 }

	 public static class GeometryDeserializer implements JsonDeserializer {
		 public Geometry deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context)
	        throws JsonParseException {
			 JsonObject g = json.getAsJsonObject();
			 JsonElement type = g.get("type");

			 if (type.getAsJsonPrimitive().getAsString().equals("Point")) {
				 PointGeometry p = new PointGeometry();
				 JsonArray coords = g.getAsJsonArray("coordinates");
				 p.coordinates = new double[coords.size()];

				 for (int i = 0; i < coords.size(); ++i) {
					 p.coordinates[i] = coords.get(i).getAsDouble();
				 }
				 return p;
			 }
			 return null;
		 }
	 }
}