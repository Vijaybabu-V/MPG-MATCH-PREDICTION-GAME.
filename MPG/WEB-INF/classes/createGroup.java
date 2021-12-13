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
//Date Packages
import java.time.LocalDate;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;  
import java.util.Calendar;  

public class createGroup extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        String gname=request.getParameter("gname");

        int gsize=Integer.parseInt(request.getParameter("gsize"));

        double fprize=Double.parseDouble(request.getParameter("fprize"));

        double sprize=Double.parseDouble(request.getParameter("sprize"));

        String desc=request.getParameter("desc");

        HttpSession session=request.getSession();
        int ID=(int)session.getAttribute("ID");




        String table1="group_details";
        String table2="group_members";





       
        try {


            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
            Date date = new Date();
            String str=formatter.format(date);
            Date today=formatter.parse(str);

           Persistence per = (Persistence)BeanUtil.lookup("Persistence");
           DataObject data=new WritableDataObject();

     
            Row gdrow=new Row(table1);
            gdrow.set("Group_Name",gname);
            gdrow.set("Group_Size",gsize);
            gdrow.set("Admin_ID",ID);
            gdrow.set("Created_Date",today);
            gdrow.set("First_Prize",fprize);
            gdrow.set("Second_Prize",sprize);
            gdrow.set("Description",desc);
            data.addRow(gdrow);
            per.add(data);

            System.out.println("GROUP ID:    "+ gdrow.get("Group_ID"));

            DataObject dataobject=new WritableDataObject();
            Row gdmrow=new Row(table2);
            gdmrow.set("Group_ID",gdrow.get("Group_ID"));
            gdmrow.set("User_ID",ID);
            dataobject.addRow(gdmrow);
            per.add(dataobject);


            



            response.sendRedirect("groups.jsp");

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }











    }







}