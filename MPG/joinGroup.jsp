<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
 height:160px;
 width:230px;
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
    <%

    int gid=Integer.parseInt(request.getParameter("gid"));
    int userID=Integer.parseInt(request.getParameter("uid"));

    out.println(gid);
    out.println(userID);
    try
    {
      Persistence per = (Persistence)BeanUtil.lookup("Persistence");
      DataObject data=new WritableDataObject();

      




    }
    catch(Exception e)
    {

      e.printStackTrace();


    }
    





    %>
    
</body>
</html>