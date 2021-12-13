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
//date packages
import java.time.LocalDate;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.util.Date;  
import java.util.Calendar;

public class playoff extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
       String table_name="team_points_table";
       String table2="matches";
        try 
        {

            Persistence per = (Persistence)BeanUtil.lookup("Persistence");
            DataObject dataobject;
            Iterator iter;
            Table table=new Table(table_name);
            SelectQueryImpl squery=new SelectQueryImpl(table);
            Column column=new Column(table_name,"*");
            //changes made here...
            SortColumn sortColumn = new SortColumn("team_points_table","Total_Points",false);
            squery.addSortColumn(sortColumn);
            squery.addSelectColumn(column);
            dataobject=per.get((SelectQuery)squery);
            iter=dataobject.getRows(table_name);
            PrintWriter out=response.getWriter();

           

            int[] team=new int[10];
            int[] point=new int[10];

            int i,j,temp,x,y;
            i=0;
            j=0;

            Row row;

            row=(Row) iter.next();
            out.println("ID: "+row.get(2)+" Total Points: "+row.get(7));
            team[i++]=(int) row.get(2);
            point[j++]=(int) row.get(7);

            row=(Row) iter.next();
            out.println("ID: "+row.get(2)+" Total Points: "+row.get(7));
            team[i++]=(int) row.get(2);
            point[j++]=(int) row.get(7);

            row=(Row) iter.next();
            out.println("ID: "+row.get(2)+" Total Points: "+row.get(7));
            team[i++]=(int) row.get(2);
            point[j++]=(int) row.get(7);

            row=(Row) iter.next();
            out.println("ID: "+row.get(2)+" Total Points: "+row.get(7));
            team[i++]=(int) row.get(2);
            point[j++]=(int) row.get(7);

            for(x=0;x<i;x++)
            {
                for(y=0;y<i-x-1;y++)
                {
                    if(point[y]<point[y+1])
                    {
                        temp=point[y];
                        point[y]=point[y+1];
                        point[y+1]=temp;

                        temp=team[y];
                        team[y]=team[y+1];
                        team[y+1]=temp;
                    }
                }
            }

            for(x=0;x<i;x++)
            {
                out.println("ID:  "+team[x]+"  Total Points:  "+point[x]);
            }

        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        Date startDate = formatter.parse("15-02-2016");
        Date endDate = formatter.parse("02-03-2016");

        Calendar start = Calendar.getInstance();
        start.setTime(startDate);
        Calendar end = Calendar.getInstance();
        end.setTime(endDate);
        int ind;
        Date date = start.getTime();

        Random randomGenerator=new Random();
        int value;


        int t1,t2,t3,t4;

        t1=team[0];
        t2=team[1];
        t3=team[2];
        t4=team[3];

        String venue;

        int s_team1=0,s_team2=0;


        
        DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");   
        String strDate = dateFormat.format(date);   
        Date Adate = dateFormat.parse(strDate);

        value=randomGenerator.nextInt(2) + 1;
        venue="Chennai";

         //updating data in the matches table
         dataobject=new WritableDataObject();
         Row matchesrow1=new Row(table2);
        matchesrow1.set("Team1",t1);
        matchesrow1.set("Team2",t4);
        matchesrow1.set("Date",Adate);
        matchesrow1.set("Venue",venue);

        if(value==1)
        {
            out.println("Semi Final 1 Winning Team:  "+t1);
            s_team1=t1;
            matchesrow1.set("Winner",t1);
            matchesrow1.set("Runner",t4);
            matchesrow1.set("Draw",false);
            


        }
        else if(value==2)
        {
            out.println("Semi Final 1 Winning Team:  "+t4);
            s_team1=t4;
             matchesrow1.set("Winner",t4);
             matchesrow1.set("Runner",t1);
             matchesrow1.set("Draw",false);

        }

        dataobject.addRow(matchesrow1);
        per.add(dataobject);
        
        start.add(Calendar.DATE, 1);
        date = start.getTime();

        //End of semi final 1

        //semi final 2 starts here



       // DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");   
         strDate = dateFormat.format(date);   
         Adate = dateFormat.parse(strDate);

        value=randomGenerator.nextInt(2) + 1;
        venue="Mumbai";

         //updating data in the matches table
         dataobject=new WritableDataObject();
         Row matchesrow2=new Row(table2);
        matchesrow2.set("Team1",t2);
        matchesrow2.set("Team2",t3);
        matchesrow2.set("Date",Adate);
        matchesrow2.set("Venue",venue);


        if(value==1)
        {
            out.println("Semi Final 2 Winning Team:  "+t2);
            s_team2=t2;
            matchesrow2.set("Winner",t2);
            matchesrow2.set("Runner",t3);
            matchesrow2.set("Draw",false);
            


        }
        else if(value==2)
        {
            out.println("Semi Final 2 Winning Team:  "+t3);
            s_team2=t3;
             matchesrow2.set("Winner",t3);
             matchesrow2.set("Runner",t2);
             matchesrow2.set("Draw",false);

        }

        dataobject.addRow(matchesrow2);
        per.add(dataobject);
        
        start.add(Calendar.DATE, 1);
        date = start.getTime();

        //Final starts here


        
    //    DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");   
        strDate = dateFormat.format(date);   
        Adate = dateFormat.parse(strDate);

        value=randomGenerator.nextInt(2) + 1;
        venue="Kolkata";

         //updating data in the matches table
         dataobject=new WritableDataObject();
         Row matchesrow3=new Row(table2);
       
        matchesrow3.set("Date",Adate);
        matchesrow3.set("Venue",venue);
        matchesrow3.set("Team1",s_team1);
        matchesrow3.set("Team2",s_team2);

        if(value==1)
        {
            out.println("Final Winning Team:  "+s_team1);
          
            matchesrow3.set("Winner",s_team1);
            matchesrow3.set("Runner",s_team2);
            matchesrow3.set("Draw",false);
            
        }
        else if(value==2)
        {
            out.println("Final Winning Team:  "+s_team2);
            matchesrow3.set("Winner",s_team2);
            matchesrow3.set("Runner",s_team1);
            matchesrow3.set("Draw",false);

        }

        dataobject.addRow(matchesrow3);
        per.add(dataobject);
        
        start.add(Calendar.DATE, 1);
        date = start.getTime();





































            /*
            while(iter.hasNext())
            {
                Row row=(Row) iter.next();
                out.println("ID: "+row.get(2)+"Total Points:  "+row.get(7));
            }
            */



      




      
      

        }
        catch (Exception e)
        {

            e.printStackTrace();

        }











    }







}