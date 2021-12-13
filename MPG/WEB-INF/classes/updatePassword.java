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

public class updatePassword extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
      
        //DataObject dataobject=new WritableDataObject();
        String pwd=request.getParameter("npwd1");


        String table="userinfo";

        HttpSession session=request.getSession();
        int ID=(int) session.getAttribute("ID");
        
        try 
        {
            Persistence per = (Persistence)BeanUtil.lookup("Persistence");
            Criteria criteria=new Criteria(new Column(table,"User_ID"),ID,0);
            UpdateQueryImpl uquery=new UpdateQueryImpl(table);
            uquery.setCriteria(criteria);
            uquery.setUpdateColumn("User_Password",pwd);
            per.update((UpdateQuery)uquery);
            response.sendRedirect("home.jsp");



           
      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }



    }

}