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
    <title>Dashboard</title>
    
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


    .container1
    {
    
    border: 2px solid #ccc;
    width:370px;
    height:435px;
    border-radius:5px;
    margin-top: 20px;
    margin-left: 50px;
    padding-top: 18px;
    
    }
    .container1 p
    {
    margin-left:23px;
    font-family:sans-serif;
    font-size: 15px;
    padding-bottom: 5px;
    
    
    }
    
   
    
    .container
    {
    
    border: 2px solid #ccc;
    width:450px;
    height:770px;
    border-radius:5px;
    margin-top: 20px;
    margin-left: 50px;
    padding-top: 18px;
    
    }
    
    .container span
    {
    
    margin-left: 23px;
    font-family: sans-serif;
    font-size: 27px;
    }
    .container p
    {
    margin-left:23px;
    font-family:sans-serif;
    font-size: 15px;
    padding-bottom: 5px;
    
    
    }
    .container input[type=text],input[type=password]
    {
    margin-left:23px;
    width: 80%;
    height:15%;
    padding: 9px;
     box-sizing: border-box;
     border: 2px solid #ccc;
     border-radius: 3px;
    
     
    
    }
    .container input[type=text]:focus,input[type=password]:focus
     {
     
         outline: none;
         border: 1px solid  rgb(0, 168, 225);
        box-shadow: 1px 1px 1px 2px  rgb(0, 168, 225);
    }
    
    .container input[type=submit]
    {
    margin-left: 23px;
    width:80%;
    padding:9px;
    margin-top:2px;
    color:white;
    font-family:sans-serif;
    font-size:16px;
    background-color: rgb(0, 168, 230);
    opacity:0.9;
    border:2px solid rgb(0, 168, 225);
    border-radius:4px;
    
    
    }
    .container1 input[type=submit]
    {
    margin-left: 23px;
    width:80%;
    padding:9px;
    margin-top:2px;
    color:white;
    font-family:sans-serif;
    font-size:16px;
    background-color: rgb(0, 168, 230);
    opacity:0.9;
    border:2px solid rgb(0, 168, 225);
    border-radius:4px;
    
    
    }

    .column {
  float: left;
  width: 50%;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
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

      <%!String uname="",mobile="",address="",city="",country="",pincode=""; %>  

      <%

      try
      {
      Persistence per = (Persistence)BeanUtil.lookup("Persistence");
      DataObject dataobject=null;

     
      int ID=(int) session.getAttribute("ID");



      String table_name="userinfo";
      Table table=new Table(table_name);
      SelectQueryImpl squery=new SelectQueryImpl(table);
      Column column=new Column(table_name,"*");
      Criteria criteria=new Criteria(new Column(table_name,"User_ID"),ID,0);
      squery.addSelectColumn(column);
      squery.setCriteria(criteria);
      dataobject=per.get((SelectQuery)squery);
      Iterator iter=dataobject.getRows(table_name,criteria);

      while(iter.hasNext())
      {
          Row row=(Row) iter.next();
          System.out.println(row.get(4)+" "+row.get(5));
          uname=(String)row.get(4);
          mobile=(String)row.get(5);
          address=(String)row.get(6);
          city=(String)row.get(7);
          country=(String)row.get(8);
          pincode=(String)row.get(9);

      }
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }










      %>

      <div class="row">
      
        <div class="column"  >
      <div class="container">
        
      <form action="updateUser" method="post">
    
        <h4 style="margin-left: 30px;">USER</h4></br>
        <p>User Name</p> <input type="text" name="uname" id="uname"  value="<%= uname%>"><br><br>
        <p>Mobile No</p> <input type="text" name="mno"  id="mno" value="<%=mobile%>"><br><br>
        <p>Address</p> <input type="text" name="address" id="address" value="<%=address%>"><br><br>
        <p>City</p> <input type="text" name="city" id="city" value="<%= city%>"><br><br>
        <p>Country</p> <input type="text" name="country" id="country" value="<%=country%>"><br><br>
        <p>Pincode</p> <input type="text" name="pcode" id="pcode" value="<%=pincode%>"><br><br>

        <input type="submit" value="UPDATE"/>
        </form>
      </div>
    </div>

    <div class="column"  >
        <div class="container1">
        <form action="updatePassword" method="post"  onsubmit="return validate()">
        <h4 style="margin-left: 30px;">CHANGE PASSWORD</h4></br>
        <p>New Password</p>
        <input type="password" name="npwd1" id="npwd1"/></br></br>
        <p>Confirm New Password</p>
        <input type="password" name="npwd2" id="npwd2"/></br></br>
        <p id="msg" style="color:red;"></p>
        <input type="submit" value="CHANGE PASSWORD"/>
        </form>
        </div>
        </div>



      </div>






</body>
<script>

  
  function validate()
  {
      

     
      var pwd1=$("#npwd1").val();
      var pwd2=$("#npwd2").val();

     if(pwd1!=pwd2)
      {
          $("#msg").text("Passwords are not equal*");
          return false;
      }
      if(pwd1.length<5)
      {
          $("#msg").text("Passwords length is too small*");
          return false;
      }
     

    

     


      

  }
  
  
  
  
  
  </script>


</html>