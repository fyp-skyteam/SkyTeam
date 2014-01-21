package dao;
import entity.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipInputStream;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.Query;

public class BootstrapManager {

	public ArrayList<String> readCSV(ZipInputStream zin) {
		BufferedReader in = new BufferedReader(new InputStreamReader(zin));
		String user;
		ArrayList<String> output = new ArrayList<String>();
	
		try {
			int count = 0;
			while ((user = in.readLine()) != null) {
				count++;
				if (count > 1) {
					output.add(user);
				}
			}
		} catch (Exception e) {

		}
		return output;
	}
	
	public ArrayList<User> convertDataToUsers(ArrayList<String> userData){
		ArrayList<User> users = new ArrayList<User>();
		for(int i=0;i<userData.size();i++){
			String[] data = userData.get(i).split(",",-1);
			String username = data[0].trim();
			String name = data[1].trim();
			String password = data[2].trim();
			
			User user = new User(username,name,password);
				users.add(user);
			
		}
		return users;
	}
	
	public void removeAll(){
    	Objectify ofy = OfyService.getOfy();
    	Iterable<Key<User>> allUserKeys = ofy.query(User.class).fetchKeys();
    	ofy.delete(allUserKeys);
	}
   	
}
