<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.io.IOException,javax.servlet.*,javax.servlet.http.*,
com.adventnet.ds.query.*,com.adventnet.mfw.bean.BeanUtil,
com.adventnet.persistence.*,java.io.PrintWriter, com.adventnet.db.api.RelationalAPI,
java.time.LocalDate,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date, java.util.Calendar,java.util.Iterator" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
         *{
        margin:0;
        }

        ul {
      list-style-type: none;
      margin-left:0;
      padding: 0;
      overflow: hidden;
      background-color:  rgb(0, 168, 225);
    }
    
    li {
    
    
    float: left;
      
      
    }
    li a {
        margin-left: 100px;
      display: inline-block;
      color: white;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
    }
    li a:hover {
      
      border: 0.5px solid white;
    }
    td,th
{
 border: 1px solid #ccc;
 height:80px;
 width:180px;
text-align: center;
 

}

.center 
{
  margin-left: auto;
  margin-right: auto;
}







    </style>
</head>
<body>
    <ul class="nav1">
  
        <li><a href="home.jsp">Home</a></li>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="groups.jsp">Groups</a></li>
        <li><a href="leaderboard.jsp">Leaderboard</a></li>
        <li><a href="login.html">Logout</a></li>
      </ul>
      
     <%! int value,groupid,maxval,gsize; String username,topuser,Email,gname,date; double fprize;%> 
      <% 
       groupid=Integer.parseInt(request.getParameter("gid"));


      try
      {
        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject=null;
        RelationalAPI relapi = RelationalAPI.getInstance();
        java.sql.Connection con = null;
        con = relapi.getConnection();
  
       
        int ID=(int) session.getAttribute("ID");


        SelectQueryImpl squery=new SelectQueryImpl(new Table("group_details"));
        Criteria criteria1=new Criteria(new Column("group_details","Admin_ID"),ID,QueryConstants.EQUAL);
        Criteria criteria2=new Criteria(new Column("group_details","Group_ID"),groupid,QueryConstants.EQUAL);
        Criteria criteria3=criteria1.and(criteria2);
        squery.addSelectColumn(Column.getColumn("group_details","*"));
        squery.setCriteria(criteria3);
        dataobject=per.get((SelectQuery)squery);
      
        if(!dataobject.isEmpty())
        {
          %>
             <h3>you are the admin of this group</h3>
             <h6 id="msg1" align="center" style="color:red;"></h6>
             <form action="addUser" method="POST" onsubmit="return checkgroup('<%=groupid%>')">
            <label for="user">Add a user:</label>
              <select name="user" id="user">
                <%
                SelectQueryImpl squery1=new SelectQueryImpl(new Table("userinfo"));
                squery1.addSelectColumn(Column.getColumn("userinfo","*"));


                SelectQueryImpl squery2=new SelectQueryImpl(new Table("group_members"));
                Criteria cr1=new Criteria(new Column("group_members","Group_ID"),groupid,QueryConstants.EQUAL);
                squery2.addSelectColumn(Column.getColumn("group_members","User_ID"));
                squery2.setCriteria(cr1);

                DerivedColumn dc=new DerivedColumn("User_ID",squery2);

                squery1.setCriteria(new Criteria(new Column("userinfo","User_ID"),dc,QueryConstants.NOT_IN));

                
                 


                DataSet rs=relapi.executeQuery(squery1,con);
                while(rs.next())
                {
                  int value=(int)rs.getValue("User_ID");
                  String username=(String)rs.getValue("User_Name");
                  String mail=(String)rs.getValue("User_Email");





                




                %>
               <option value="<%=value%>"><%=username%>  <pre>      <%=mail%></pre></option>
                <%


                }



                %>
             </select>

              <input type="hidden" name="group" value="<%=groupid%>">

              <input type="submit" class="btn btn-outline-success btn-lg" value="Add"/>




             </form>
           
             <br><br><br>

          <%


        }
       







      }
      catch(Exception e)
      {
        e.printStackTrace();

      }
     
      
      
      
      
      
      
      
      
      %>

      <%

      try
      {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data;
        RelationalAPI relapi = RelationalAPI.getInstance();
        java.sql.Connection conn = null;
        conn = relapi.getConnection();

        SelectQueryImpl query=new SelectQueryImpl(new Table("group_details"));
        Criteria gcriteria=new Criteria(Column.getColumn("group_details","Group_ID"),groupid,QueryConstants.EQUAL);
        query.addSelectColumn(Column.getColumn("group_details","*"));
        query.setCriteria(gcriteria);

        DataSet dt=relapi.executeQuery(query,conn);
        while(dt.next())
        {
          DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy"); 
          String strdate=dateFormat.format(dt.getValue("Created_Date"));
           date=strdate;
          gname=(String)dt.getValue("Group_Name");
          gsize=(int)dt.getValue("Group_Size");
          fprize=(double)dt.getValue("First_Prize");





        }
        dt.close();
        conn.close();




      }
      catch(Exception e)
      {

        e.printStackTrace();
      }
      
      
      
      %>
      <h2>Group Name: <%=gname%></h2>
      <h2>Group Size: <%=gsize%></h2>
      <h2>First Prize: <%=fprize%></h2>
      <h2>Created Date: <%=date%></h2>



      <table border="1px" cellspacing="1" cellpadding="4" class="center">
        <tr>
            <th>S.no</th>
            <th>Name</th>
            <th>E-Mail</th>
            <th>Score</th>
        </tr>

    <%

     
      out.println(groupid);


      try
      {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject=null;
        RelationalAPI relapi = RelationalAPI.getInstance();
        java.sql.Connection con = null;
        con = relapi.getConnection();

        SelectQueryImpl squery=new SelectQueryImpl(new Table("userinfo"));
        Criteria joincr1=new Criteria(Column.getColumn("userinfo","User_ID"),Column.getColumn("group_members","User_ID"),QueryConstants.EQUAL);
        Criteria joincr2=new Criteria(Column.getColumn("group_members","Group_ID"),groupid,QueryConstants.EQUAL);
        Criteria joincr3=joincr1.and(joincr2);
        Join join1=new Join("userinfo","group_members",joincr3,Join.INNER_JOIN);

        Criteria joincr4=new Criteria(Column.getColumn("userinfo","User_ID"),Column.getColumn("user_points_table","User_ID"),QueryConstants.EQUAL);
        Join join2=new Join("userinfo","user_points_table",joincr4,Join.INNER_JOIN);

        squery.addSelectColumn(Column.getColumn("userinfo","*"));
        squery.addSelectColumn(Column.getColumn("group_members","*"));
        squery.addSelectColumn(Column.getColumn("user_points_table","*"));

        squery.addJoin(join1);
        squery.addJoin(join2);

        DataSet ds =relapi.executeQuery(squery,con);
        int count=1;
        int temp=0;
        maxval=0;
        while(ds.next())
        {
            String name=(String)ds.getValue("User_Name");
            String mail=(String)ds.getValue("User_Email");
            int point=(int)ds.getValue("Total_Points");
            if(point>maxval)
            {
              maxval=point;
              topuser=name;
              Email=mail;
              
            }



           %>
           <tr>
           <td>
               <%=count%>
           </td>
           <td>
               <%=name%>
           </td>
           <td>
               <%=mail%>
           </td>
           <td>
               <%=point%>
           </td>


           </tr>


     
        <%
        count++;

        }
        ds.close();
        con.close();






      }
      catch(Exception e)
      {

        e.printStackTrace();



      }
      
    
    
    
    
    
    
    %>
      </table>

     <pre><h1 align='center'>Group 1St Rank <%=topuser%>  Total Points:  <%=maxval%></h1></pre>
     <input type="hidden"  id="gid1"/>
    
</body>
<script>

function checkgroup(val)
  {



    $.post("checkAvailability",{
           grpid : val
      }, function(data, status) { 
                  
                if(data=="failure")
               {
                  $("#msg1").text("you can't add members in this group as group limit is exceeded*");
                  document.getElementById("gid1").value=0;
                  
                 
                 
              }
              else
              {
                  document.getElementById("gid1").value=1;
              }
          });
        
           
             if(document.getElementById("gid1").value==0)
             {
               return false;
             }







  }
 
</script>
</html>