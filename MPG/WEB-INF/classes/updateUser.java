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

public class updateUser extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
      
        //DataObject dataobject=new WritableDataObject();
        String uname=request.getParameter("uname");

        String mobile=request.getParameter("mno");


        String address=request.getParameter("address");

        String city=request.getParameter("city");

        String country=request.getParameter("country");

        String pincode=request.getParameter("pcode");


        String table="userinfo";

        HttpSession session=request.getSession();
        int ID=(int) session.getAttribute("ID");
        
        try 
        {
            Persistence per = (Persistence)BeanUtil.lookup("Persistence");
            Criteria criteria=new Criteria(new Column(table,"User_ID"),ID,0);
            UpdateQueryImpl uquery=new UpdateQueryImpl(table);
            uquery.setCriteria(criteria);
            uquery.setUpdateColumn("User_Name",uname);
            uquery.setUpdateColumn("User_Mobile_No",mobile);
            uquery.setUpdateColumn("User_Address",address);
            uquery.setUpdateColumn("User_City",city);
            uquery.setUpdateColumn("User_Country",country);
            uquery.setUpdateColumn("User_Pincode",pincode);
            per.update((UpdateQuery)uquery);
            response.sendRedirect("home.jsp");



           
      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }



    }

}