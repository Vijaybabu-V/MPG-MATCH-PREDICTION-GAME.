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

public class joinGroups extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        int groupid=Integer.parseInt(request.getParameter("groupid"));

        System.out.println("groupid:::       "+groupid);

        HttpSession session=request.getSession();
        int ID=(int)session.getAttribute("ID");


        String table="group_members";
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data=new WritableDataObject();

     
            Row grouprow=new Row(table);
            grouprow.set("Group_ID",groupid);
            grouprow.set("User_ID",ID);
            data.addRow(grouprow);
            per.add(data);

            response.sendRedirect("groups.jsp");


           

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }











    }







}