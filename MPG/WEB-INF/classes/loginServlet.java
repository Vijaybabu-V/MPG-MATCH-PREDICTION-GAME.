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

public class loginServlet extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
        String uname=(String) request.getParameter("mail");
        String password=(String) request.getParameter("pwd");
        System.out.println(uname+"  "+password);
        String table_name="userinfo";
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject=null;
        Table table=new Table(table_name);
        SelectQueryImpl squery=new SelectQueryImpl(table);
        Column column1=new Column(table_name,"*");
        Criteria criteria1=new Criteria(new Column(table_name,"User_Email"),uname,0);
        Criteria criteria2=new Criteria(new Column(table_name,"User_Password"),password,0);
        Criteria criteria3=criteria1.and(criteria2);
        squery.addSelectColumn(column1);
        
        squery.setCriteria(criteria3);
        dataobject=per.get((SelectQuery)squery);

       
        Row row=dataobject.getFirstRow(table_name);
        int ID=(int)row.get(1);
        HttpSession session=request.getSession();
        session.setAttribute("ID",ID);
        System.out.print(session.getAttribute("ID"));
        System.out.println("USER ID   "+ID);
        if(!dataobject.isEmpty())
        {
            response.sendRedirect("home.jsp");
           
        }

       





      
      

        }
        catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.html");
        }











    }







}