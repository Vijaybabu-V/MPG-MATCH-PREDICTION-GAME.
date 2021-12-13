<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,java.io.IOException,javax.servlet.*,javax.servlet.http.*,
com.adventnet.ds.query.*,com.adventnet.mfw.bean.BeanUtil,
com.adventnet.persistence.*,java.io.PrintWriter, com.adventnet.db.api.RelationalAPI,
java.time.LocalDate,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date, java.util.Calendar,java.util.Iterator" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HOME PAGE</title>
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

  <%! String name1; %>

<%
    if(session.getAttribute("ID")==null)
    {
	  response.sendRedirect("login.html");
    }

    try
    {
      Persistence per = (Persistence)BeanUtil.lookup("Persistence");
      DataObject data;
      int ID=(int)session.getAttribute("ID");
      SelectQueryImpl query=new SelectQueryImpl(new Table("userinfo"));
      Criteria uname_cr=new Criteria(Column.getColumn("userinfo","User_ID"),ID,QueryConstants.EQUAL);
      query.addSelectColumn(Column.getColumn("userinfo","*"));
      query.setCriteria(uname_cr);
      data=per.get((SelectQuery)query);
      Row row=data.getFirstRow("userinfo");
      name1=(String)row.get(4);




    }
    catch(Exception e)
    {
      e.printStackTrace();
    }





%>
    <ul>
  
        <li><a href="home.jsp">Home</a></li>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="groups.jsp">Groups</a></li>
        <li><a href="leaderboard.jsp">Leaderboard</a></li>
        <li><a href="login.html">Logout</a></li>
      </ul>
      



      <h1>Welcome... <%=name1%> </h1>



    
<h1>HOME PAGE</h1>

<table cellspacing="1" cellpadding="4" class="center">
<th>MATCH ID</th>
<th>DATE</th>
<th>VENUE</th>
<th>OPTION 1</th>
<th>OPTION 2</th>
<th>OPTION 3</th>
<%

try
{

  Persistence per = (Persistence)BeanUtil.lookup("Persistence");
  DataObject dataobject=null;
  RelationalAPI relapi = RelationalAPI.getInstance();
  java.sql.Connection con = null;
  con = relapi.getConnection();
  int ID=(int)session.getAttribute("ID");

  String csk="csk1.png";
  String mi="mi1.png";
  String kkr="kkr1.png";
  String dc1="dc1.png";

  SelectQueryImpl squery1=new SelectQueryImpl(new Table("matches"));
  squery1.addSelectColumn(Column.getColumn("matches","*"));

  SelectQueryImpl squery2=new SelectQueryImpl(new Table("prediction"));
  Criteria cr1=new Criteria(new Column("prediction","User_ID"),ID,QueryConstants.EQUAL);
  squery2.addSelectColumn(Column.getColumn("prediction","Match_ID"));
  squery2.setCriteria(cr1);
  DerivedColumn dc=new DerivedColumn("Match_ID",squery2);

  squery1.setCriteria(new Criteria(new Column("matches","Match_ID"),dc,QueryConstants.NOT_IN));







  DataSet ds =relapi.executeQuery(squery1,con);
  dataobject=per.get((SelectQuery)squery1);
  DataObject data;

  String timg1="",timg2="";

  while(ds.next())
  {

    int mid=(int)ds.getValue("Match_ID");
    int team1=(int)ds.getValue("Team1");
    int team2=(int)ds.getValue("Team2");
    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy"); 
    String strdate=dateFormat.format(ds.getValue("Date"));
    String date=strdate;
    String venue=(String)ds.getValue("Venue");


    SelectQueryImpl squery3=new SelectQueryImpl(new Table("team_details"));
    Criteria cr3=new Criteria(new Column("team_details","Team_ID"),team1,QueryConstants.EQUAL);
    squery3.addSelectColumn(Column.getColumn("team_details","*"));
    squery3.setCriteria(cr3);
    data=per.get((SelectQuery)squery3);
    Row row1=data.getFirstRow("team_details");
    String tname1=(String)row1.get(2);

    data=null;

    SelectQueryImpl squery4=new SelectQueryImpl(new Table("team_details"));
    Criteria cr4=new Criteria(new Column("team_details","Team_ID"),team2,QueryConstants.EQUAL);
    squery4.addSelectColumn(Column.getColumn("team_details","*"));
    squery4.setCriteria(cr4);
    data=per.get((SelectQuery)squery4);
    Row row2=data.getFirstRow("team_details");
    String tname2=(String)row2.get(2);

    if(team1==1)
    {
      timg1=csk;
    }
    else if(team1==2)
    {
      timg1=mi;
    }
    else if(team1==3)
    {
      timg1=kkr;
    }
    else if(team1==4)
    {
      timg1=dc1;
    }

    if(team2==1)
    {
      timg2=csk;
    }
    else if(team2==2)
    {
      timg2=mi;
    }
    else if(team2==3)
    {
      timg2=kkr;
    }
    else if(team2==4)
    {
      timg2=dc1;
    }


    String tdate="05-02-2016";
    Date date1 = dateFormat.parse(tdate);
    Date date2 = dateFormat.parse(date);

    

    if(date2.after(date1)) {
      
  


    

    %>
    <tr id="del">
      

     
        <th><%=mid%></th>
        <th><%=strdate%></th>
        <th><%=venue%></th>
        <td>

          <img src="<%=timg1%>" width="82" height="92"><br>
          <button class="btn btn-outline-primary btn-lg"  onclick="doDelete(this,'<%=mid%>','<%=team1%>')"><%=tname1%><%=team1%></button>
       
        </td>
        <td>
          <img src="<%=timg2%>" width="82" height="92"><br>
          <button  class="btn btn-outline-danger btn-lg"    onclick="doDelete(this,'<%=mid%>','<%=team2%>')"><%=tname2%><%=team2%></button>
        
        </td>
        <td><button class="btn btn-outline-dark btn-lg" onclick="doDelete(this,'<%=mid%>',-1)">DRAW</button></td>
      
     
     
    </tr>
  
  



    <%


  }





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

</body>

<script type="text/javascript">
  function doDelete(val,val1,val2)
  {
    console.log(val1);
    console.log(val2);
  
    $(val).closest('tr').remove();

    $.post("deleteMatches",
             {
               mid: val1,
               prd: val2


            });
    
              
    
    
    
  }
  
  
  
  
  
  </script>
</html>