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

public class checkAvailability extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        int groupid=Integer.parseInt(request.getParameter("grpid"));
        System.out.print(groupid);
		PrintWriter out = response.getWriter();
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject;
        RelationalAPI relapi = RelationalAPI.getInstance();
        java.sql.Connection con = null;
        con = relapi.getConnection();



        SelectQueryImpl squery=new SelectQueryImpl(new Table("group_details"));
        Criteria criteria1=new Criteria(Column.getColumn("group_details","Group_ID"),groupid,QueryConstants.EQUAL);
        squery.addSelectColumn(Column.getColumn("group_details","*"));
        squery.setCriteria(criteria1);
        dataobject=per.get((SelectQuery)squery);
        Row row1=dataobject.getFirstRow("group_details");
        int size=(int)row1.get(3);



        SelectQuery squery1=new SelectQueryImpl(new Table("group_members"));
        Criteria criteria2=new Criteria(Column.getColumn("group_members","Group_ID"),groupid,QueryConstants.EQUAL);
        Column column1=new Column("group_members","Group_ID");
        Column Gcount=column1.count();
        Gcount.setColumnAlias("G_COUNT");
        squery1.addSelectColumn(column1);
        squery1.addSelectColumn(Gcount);
        squery1.setCriteria(criteria2);
        DataSet ds =relapi.executeQuery(squery1,con);
        ds.next();
        int tot_members=(int)ds.getValue("G_COUNT");

        System.out.println("GROUP_DETAILS SIZE:  "+size+"       GROUP_MEMBERS SIZE:     "+tot_members);





        response.setContentType("text/plain"); 
        response.setCharacterEncoding("UTF-8");
        
        if(size==tot_members)
        {
            response.getWriter().write("failure"); 
            //System.out.println(groupid+"Group limit exceeded!!!!!!!!!!!!!!!!");
            
			
           

        }
        else
        {
            
            response.getWriter().write("success"); 
            //System.out.println(groupid+"User Addded In the Group");
				
        }



        ds.close();
        con.close();
        






     
          
      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }
      
            





    }

}