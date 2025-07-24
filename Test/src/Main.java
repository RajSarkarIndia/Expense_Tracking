import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Main {
public static void main(String args[]) {
	
	ApplicationContext context=new ClassPathXmlApplicationContext("ApplicationContext.xml");
	testClass ob=(testClass)context.getBean("testC");
	System.out.println(ob.getName());
	ob.setName("RajSarkar");
	System.out.println(ob.getName());
	
	
}
}
