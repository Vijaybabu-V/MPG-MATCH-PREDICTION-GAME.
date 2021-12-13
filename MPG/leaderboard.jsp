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
    <title>Leaderboard</title>
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
   width:200px;
   text-align: center;
 

   }

    .center 
   {
     margin-left: auto;
     margin-right: auto;
     
    border-collapse: separate;
    border-spacing: 0 1em;
   }
    
    </style>
</head>
<body>
    <ul>
  
        <li><a href="home.jsp">Home</a></li>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="groups.jsp">Groups</a></li>
        <li><a href="leaderboard.jsp">Leaderboard</a></li>
        <li><a href="login.html">Logout</a></li>
      </ul>
   

      <%!int no_matches,win,loss,total; %>
      <%

      int ID=(int)session.getAttribute("ID");
      out.println(ID);

      try
      {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data;
        SelectQueryImpl squery=new SelectQueryImpl(new Table("user_points_table"));
        Criteria criteria=new Criteria(new Column("user_points_table","User_ID"),ID,QueryConstants.EQUAL);
        Column column1=new Column("user_points_table","*");
        squery.addSelectColumn(column1);
        squery.setCriteria(criteria);
        data=per.get((SelectQuery)squery);


        Iterator iter=data.getRows("user_points_table",criteria);

        while(iter.hasNext())
        {
            Row row=(Row) iter.next();
            no_matches=(int)row.get(3);
            win=(int)row.get(4);
           loss=(int)row.get(5);
            total=(int)row.get(6);
            
  
        }
    







      }
      catch(Exception e)
      {
        e.printStackTrace();
      
      }


      
     


      %>

      <pre><h1 align='center'>No of Matches:  <%=no_matches%> | Win:  <%=win%> | Loss:  <%=loss%> | Total Points:  <%=total%></h1></pre>
      <table cellspacing="1" cellpadding="4" class="center">
        <th>USER MAIL ID</th>
        <th>USER NAME</th>
        <th>NO OF MATCHES</th>
        <th>WIN</th>
        <th>LOSS</th>
        <th>POINTS</th>
       
    <%

      try
      {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject=null;
        RelationalAPI relapi = RelationalAPI.getInstance();
        java.sql.Connection con = null;
        con = relapi.getConnection();


        SelectQueryImpl squery1=new SelectQueryImpl(new Table("user_points_table"));

        Join join=new Join("user_points_table","userinfo",new String[]{"User_ID"},new String[]{"User_ID"},Join.INNER_JOIN);

        SortColumn sortColumn = new SortColumn("user_points_table","Total_Points",false);

        squery1.addSortColumn(sortColumn);

        squery1.addJoin(join);
        squery1.addSelectColumn(Column.getColumn("userinfo","*"));
       

        squery1.addSelectColumn(Column.getColumn("user_points_table","*"));

        DataSet rs=relapi.executeQuery(squery1,con);

        while(rs.next())
        {
          String mailid=(String)rs.getValue("User_Email");
          String name=(String)rs.getValue("User_Name");

          int matches=(int)rs.getValue("No_Of_Matches");
          int win=(int)rs.getValue("Win");
          int loss=(int)rs.getValue("Loss");
          int tot=(int)rs.getValue("Total_Points");

          %>



          <tr>
            <td>
              <%=mailid%>
            </td>
          <td>
            <%=name%>
          </td>

             <td>
             <%=matches%>

             </td>
             <td>
               <%=win%>

             </td>
             <td>
              <%=loss%>
             </td>
             <td>
              <%=tot%>
             </td>
             <tr>




          <%





        }





       rs.close();
       con.close();

      }
      catch(Exception e)
      {
        e.printStackTrace();
      }

%>


</table>

    

      


     
    
</body>
</html>