package entity;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

public class OfyService {
	static{
		ObjectifyService.register(Location.class);
		ObjectifyService.register(User.class);
		ObjectifyService.register(LocationMetadata.class);
	}
	
	public static Objectify getOfy(){
		Objectify ofy = ObjectifyService.begin();
		return ofy;
	}
}
