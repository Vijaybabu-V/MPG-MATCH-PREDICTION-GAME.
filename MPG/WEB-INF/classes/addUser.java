import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import java.sql.*;
import com.adventnet.persistence.*;
import java.io.PrintWriter;
import com.adventnet.db.api.RelationalAPI;
import java.util.*;

public class addUser extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {


    int user=Integer.parseInt(request.getParameter("user"));
    int groupid=Integer.parseInt(request.getParameter("group"));


        System.out.println("ADDUSER:  "+user+" GROUPID   "+ groupid);

        PrintWriter out=response.getWriter();
        out.println(user);
        out.print(groupid);

        String table="group_members";

       
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data=new WritableDataObject();
        Row grouprow=new Row(table);
        grouprow.set("Group_ID",groupid);
        grouprow.set("User_ID",user);
        data.addRow(grouprow);
        per.add(data);


        response.sendRedirect("display.jsp?gid="+groupid);

     
            
           

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }











    }







}