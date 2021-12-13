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

public class signup extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        String mail=request.getParameter("mail");

        String password1=request.getParameter("pwd1");

        String password2=request.getParameter("pwd2");

        String uname=request.getParameter("uname");

        String mobile=request.getParameter("mno");


        String address=request.getParameter("address");

        String city=request.getParameter("city");

        String country=request.getParameter("country");

        String pincode=request.getParameter("pcode");


        String table="userinfo";
        String points_table="user_points_table";
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data=new WritableDataObject();

     
            Row userdetailsrow=new Row(table);
            userdetailsrow.set("User_Email",mail);
            userdetailsrow.set("User_Password",password1);
            userdetailsrow.set("User_Name",uname);
            userdetailsrow.set("User_Mobile_No",mobile);
            userdetailsrow.set("User_Address",address);
            userdetailsrow.set("User_City",city);
            userdetailsrow.set("User_Country",country);
            userdetailsrow.set("User_Pincode",pincode);
            data.addRow(userdetailsrow);
            per.add(data);

            Table user_table=new Table(table);
            SelectQueryImpl squery=new SelectQueryImpl(user_table);
            Column column=new Column(table,"*");
            Criteria criteria=new Criteria(new Column(table,"User_Email"),mail,0);
            squery.addSelectColumn(column);
            squery.setCriteria(criteria);
            data=per.get((SelectQuery)squery);
            Row rowid=data.getFirstRow(table);
            int user_ID=(int)rowid.get(1);

            System.out.println("user ID:  "+user_ID);

            HttpSession session=request.getSession();
            session.setAttribute("ID",user_ID);

            System.out.println("Session:  "+session.getAttribute("ID"));

            DataObject dataobject=new WritableDataObject();
            Row points_row=new Row(points_table);
            points_row.set("User_ID",user_ID);
            points_row.set("No_Of_Matches",0);
            points_row.set("Win",0);
            points_row.set("Loss",0);
            points_row.set("Total_Points",0);
            dataobject.addRow(points_row);
            per.add(dataobject);




            response.sendRedirect("home.jsp");

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }











    }







}