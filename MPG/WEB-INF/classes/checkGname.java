import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import java.sql.*;
import com.adventnet.persistence.*;
import java.io.PrintWriter;
import com.adventnet.db.api.RelationalAPI;
import java.util.Iterator;

public class checkGname extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        String gname=(String)request.getParameter("gname");
        System.out.print(gname);

        String tableName="group_details";
        Connection conn = null;
		DataSet ds = null;
		DataObject data = null;
		Criteria criteria = null;
		Iterator it = null;
		PrintWriter out = response.getWriter();
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");


        criteria = new Criteria(Column.getColumn(tableName,"Group_Name"),gname,0);
		data =per.get(tableName,(Criteria) criteria);
		it = data.getRows(tableName,(Criteria) criteria);


        response.setContentType("text/plain"); 
        response.setCharacterEncoding("UTF-8");

        if(it.hasNext())
        {
            response.getWriter().write("failure"); 
            System.out.println("already exists!!!!!!!!!!!!!!!!");
            
			
           // response.sendRedirect("signup.html");

        }
        else
        {
            response.getWriter().write("success"); 
           // response.sendRedirect("signup.html");
				
        }






     
          
      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }





    }

}