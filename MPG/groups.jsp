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
    <title>Groups</title>
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        *{
        margin:0;
        }

        .container
    {
    
    border: 2px solid #ccc;
    width:420px;
    height:785px;
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

    .container input[type=text],input[type=password],input[type=number]
    {
    margin-left:23px;
    width: 80%;
    height:15%;
    padding: 9px;
     box-sizing: border-box;
     border: 2px solid #ccc;
     border-radius: 3px;
    
     
    
    }

    .container input[type=text]:focus,input[type=password]:focus,input[type=numbers]:focus
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






        .nav1 {
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

        .column {
         float: left;
          width: 33.3%;
         }


        .row:after {
       content: "";
        display: table;
       clear: both;
        }

        .list1 ul,.list2 ul
        {
          margin-top: 70px;
          margin-left: 20px;
          height:380px;
           width:78%;
          }
      .list1 ul,.list2 ul
      {
        overflow:hidden; 
        overflow-y:scroll;
      }

      .list1 li,.list2  li
      {
        display: inline-block;

      }
      td
    {
   
    height:60px;
     width:175px;
     
    text-align: center;

  }
  button
{
width:45%;
padding:9px;
margin-top:2px;
color:white;
font-family:sans-serif;
font-size:10px;
background-color: rgb(0, 168, 230);
opacity:0.9;
border:2px solid rgb(0, 168, 225);
border-radius:4px;


}
#join
{
  width:55%;
padding:9px;
margin-top:2px;
color:white;
font-family:sans-serif;
font-size:10px;
background-color: rgb(0, 168, 230);
opacity:0.9;
border:2px solid rgb(0, 168, 230);
border-radius:4px;
}

#view
{
  width:55%;
padding:9px;
margin-top:2px;
color:white;
font-family:sans-serif;
font-size:10px;
background-color: rgb(7, 161, 15);
opacity:0.9;
border:2px solid rgb(162, 231, 171);
border-radius:4px;
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
      <%!int gid,uid; %>  


      <div class="row">
        <div class="column">
          <div class="container">
        
            <form action="createGroup" method="post" onsubmit="return validate()">
          
              <h4 style="margin-left: 30px;">CREATE GROUP</h4></br>
              <p>Group Name</p> <input type="text" name="gname" id="gname"  value=""><br><br>
              <p>Group Size</p> <input type="number" name="gsize"  id="gsize" value=""><br><br>
              <p>First Prize</p> <input type="text" name="fprize" id="fprize" value=""><br><br>
              <p>Second Prize</p> <input type="text" name="sprize" id="sprize" value=""><br><br>
              <p>Description</p> <input type="text" name="desc" id="desc" value=""><br><br>
              <p id="msg" style="color:red;"></p>
              <input type="submit" value="CREATE"/>
              </form>
              <input type="hidden"  id="gid"/>
              <input type="hidden"  id="gid1"/>
            </div>






        </div>
        <div class="column">
          
          <div class="list1">
            
            <ul>
              <h4 style="margin-left: 30px;">YOUR GROUPS</h4>
              <table border="0px" cellspacing="0" cellpadding="0">
                
              <%

              try{
              Persistence per = (Persistence)BeanUtil.lookup("Persistence");
              DataObject dataobject=null;
              RelationalAPI relapi = RelationalAPI.getInstance();
              java.sql.Connection con = null;
              con = relapi.getConnection();
        
             
              int ID=(int) session.getAttribute("ID");

              String table_name="group_details";

              Table table=new Table(table_name);
              SelectQueryImpl squery=new SelectQueryImpl(table);


             

              Criteria criteria=new Criteria(new Column("group_members","User_ID"),ID,QueryConstants.EQUAL);
              Join join=new Join("group_details","group_members",new String[]{"Group_ID"}, new String[]{"Group_ID"}, Join.INNER_JOIN);
              

              squery.addSelectColumn(Column.getColumn("group_details", "*"));
              squery.addSelectColumn(Column.getColumn("group_members", "*"));
              squery.addJoin(join);
              squery.setCriteria(criteria);
            
              DataSet ds =relapi.executeQuery(squery,con);
              System.out.println("DATASET"+ds);
              while(ds.next())
              {
                System.out.println("GROUP_ID:  "+ds.getValue("Group_ID"));
                int gid=(int)ds.getValue("Group_ID");
                
                %>
                
                <tr  style="outline: thin solid">
                 <td>

                  <%= ds.getValue("Group_Name")%>
                 
                 </td>
                 <td>

                  <button onclick="document.location='display.jsp?gid=<%=gid%>'">View</button>
                 
                 </td>
                
                </tr>

                <%

              }
              ds.close();
              con.close();



              
              
              
              
              
              
              
              
              }
                catch (Exception e) {
                  e.printStackTrace();
                }
              


                %>
                
              </table>
            </ul>
          </div>





        </div>
        <div class="column">
          <h4 id="msg1" align="center" style="color:red;"></h4>
          
          <div class="list2">
            
            <ul>
              <h4 style="margin-left: 30px;">GROUPS</h4>
              <table border="0px" cellspacing="0" cellpadding="0">
                <%

              try{
              Persistence per = (Persistence)BeanUtil.lookup("Persistence");
              RelationalAPI relapi = RelationalAPI.getInstance();
              java.sql.Connection con = null;
              con = relapi.getConnection();
        
             
              int ID=(int) session.getAttribute("ID");

              String table_name="group_details";

              Table table=new Table(table_name);
              SelectQueryImpl squery1=new SelectQueryImpl(table);
              squery1.addSelectColumn(Column.getColumn("group_details","*"));

              SelectQueryImpl squery2=new SelectQueryImpl(new Table("group_members"));
              Criteria criteria1=new Criteria(new Column("group_members","User_ID"),ID,QueryConstants.EQUAL);

              squery2.addSelectColumn(Column.getColumn("group_members","Group_ID"));
              squery2.setCriteria(criteria1);

              DerivedColumn dc=new DerivedColumn("Group_ID",squery2);

              squery1.setCriteria(new Criteria(new Column("group_details","Group_ID"),dc,QueryConstants.NOT_IN));






              
            
              DataSet ds =relapi.executeQuery(squery1,con);
              
              while(ds.next())
              {
                System.out.println("GROUP_ID:  "+ds.getValue("Group_ID"));
                int gid=(int)ds.getValue("Group_ID");
                
                %>
                
                <tr  style="outline: thin solid">
                 <td>

                  <%= ds.getValue("Group_Name")%>
                 
                 </td>
                 <td>

                  <button id="view" onclick="document.location='display.jsp?gid=<%=gid%>'">View</button>
                 
                 
                 </td>
                 <td>
                   <form action="joinGroups" method="post"  onsubmit="return check('<%=gid%>')">
                     <input type="hidden" name="groupid" id="group_id" value="<%=gid%>">
                     <input type="submit" value="Join" id="join">
                   
                   </form>
                  

                 </td>
                
                </tr>

                <%

              }

              ds.close();
              con.close();



              
              
              
              
              
              
              
              
              }
                catch (Exception e) {
                  e.printStackTrace();
                }
              


                %>
                
              </table>

            </ul>
          </div>








        </div>
      </div>
    
</body>
<script>

  
  function validate()
  {
      

      
      var gname=$("#gname").val();
    


      if(gname=="")
      {
        $("#msg").text("Enter the Group Name*");
        return false;
      }
      else
      {

     $.post("checkGname",{
           gname : gname
      }, function(data, status) { 
                  
                if(data=="failure")
               {
                  $("#msg").text("This Group Name Already Exists*");
                  $('#gname').focus();
                  document.getElementById("gid").value=0;
                  
                 
                 
              }
              else
              {
                  document.getElementById("gid").value=1;
              }
          });
        
           
             if(document.getElementById("gid").value==0)
             {
               return false;
             }
    }
        
     
  }


  function check(val)
  {

    var group_id=$("#group_id").val();


    console.log(val);

    $.post("checkAvailability",{
           grpid : val
      }, function(data, status) { 
                  
                if(data=="failure")
               {
                  $("#msg1").text("you can't join in this group as group limit is exceeded*");
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