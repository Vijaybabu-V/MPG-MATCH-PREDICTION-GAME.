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
public class schedule extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

       PrintWriter out=response.getWriter();
       out.println("Hello Matches");


        String table1="team_details";
        String table2="matches";
        String table3="team_points_table";
        try {

        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject dataobject=null;
        Criteria criteria=null;
        Table table=new Table(table1);
        SelectQueryImpl squery=new SelectQueryImpl(table);
        Column column1=new Column(table1,"*");
        squery.addSelectColumn(column1);

        dataobject = per.get((SelectQuery)squery);


        Iterator it=dataobject.getRows(table1,criteria);

        ArrayList<Integer> list=new ArrayList<Integer>();

        ArrayList<String> matches=new ArrayList<String>();


        while(it.hasNext())
        {
            Row r=(Row) it.next();

            out.println(r.get(1)+" "+r.get(2));

            int id=(int)r.get(1);
            list.add(id);
        }

        out.println(list);
        //adding the matches between two teams in arraylist.
        for(int i=0;i<list.size();i++)
        {
            for(int j=i;j<list.size();j++)
            {
                if(i!=j)
                {
                    matches.add(Integer.toString(list.get(i))+"-"+Integer.toString(list.get(j)));
                }

            }
        }
        Collections.shuffle(matches);
     
        
        DataObject data=new WritableDataObject();

        for(int i=0;i<matches.size();i++)
        {
            out.println(matches.get(i));

        }


        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        Date startDate = formatter.parse("01-02-2016");
        Date endDate = formatter.parse("02-03-2016");

        Calendar start = Calendar.getInstance();
        start.setTime(startDate);
        Calendar end = Calendar.getInstance();
        end.setTime(endDate);
        int ind;
        Date date = start.getTime();

        Random randomGenerator=new Random();
        int value;

        //1st set of matches
        for (ind=0; ind<matches.size() ;ind++)
         {

            String[] str=matches.get(ind).split("-");
            int a=Integer.parseInt(str[0]);
            int b=Integer.parseInt(str[1]);


            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");   
            String strDate = dateFormat.format(date);   

           
             Date Adate = dateFormat.parse(strDate);

            value=randomGenerator.nextInt(3) + 1;

            //sout.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+value);
            System.out.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+randomGenerator.nextInt(3) + 1);

            
            Table table_venue=new Table(table1);
            SelectQueryImpl squery2=new SelectQueryImpl(table_venue);
            Column column2=new Column(table1,"*");
            Criteria criteria2=new Criteria(new Column(table1,"Team_ID"),a,0);
            squery2.addSelectColumn(column1);
            squery2.setCriteria(criteria2);
            dataobject = per.get((SelectQuery)squery2);

            Row row=dataobject.getFirstRow(table1);

            String venue=(String) row.get(4);


            out.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+value+"  venue:  "+venue);


            //updating data in the matches table
            dataobject=new WritableDataObject();
            Row matchesrow=new Row(table2);

            matchesrow.set("Team1",a);
            matchesrow.set("Team2",b);
            matchesrow.set("Date",Adate);
            matchesrow.set("Venue",venue);
            

            //updating team_points_table
            Table points_table=new Table(table3);
            DataObject dataobject_team1,dataobject_team2;
            int no_matches1,win1,loss1,draw1,total1;
            int no_matches2,win2,loss2,draw2,total2;



             //team_points_table for 1st team
             SelectQueryImpl squery3=new SelectQueryImpl(points_table);
             Column column3=new Column(table3,"*");
             Criteria criteria_va3=new Criteria(new Column(table3,"Team_ID"),a,0);
             squery3.addSelectColumn(column3);
             squery3.setCriteria(criteria_va3);
             dataobject_team1= per.get((SelectQuery)squery3);
             Row team_row1=dataobject_team1.getFirstRow(table3);
             no_matches1=(int) team_row1.get(3);
             win1=(int) team_row1.get(4);
             loss1=(int) team_row1.get(5);
             draw1=(int) team_row1.get(6);
             total1=(int) team_row1.get(7);

             System.out.println("Hello");



        
            //team_points_table for 2nd team
            SelectQueryImpl squery4=new SelectQueryImpl(points_table);
            Column column4=new Column(table3,"*");
            Criteria criteria_vb3=new Criteria(new Column(table3,"Team_ID"),b,0);
            squery4.addSelectColumn(column4);
            squery4.setCriteria(criteria_vb3);
            dataobject_team2= per.get((SelectQuery)squery4);
            Row team_row2=dataobject_team2.getFirstRow(table3);
            no_matches2=(int) team_row2.get(3);
            win2=(int) team_row2.get(4);
            loss2=(int) team_row2.get(5);
            draw2=(int) team_row2.get(6);
            total2=(int) team_row2.get(7);

           




            if(value==3)
            {
                matchesrow.set("Winner",0);
                matchesrow.set("Runner",0);
                matchesrow.set("Draw",true);    
                
               

                //updating team_points_table for team1
                no_matches1++;
                draw1++;
                total1++;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Draw",draw1);
                updateQuery1.setUpdateColumn("Total_Points",total1);
                per.update((UpdateQuery)updateQuery1);


                //updating team_points_table for team2
                no_matches2++;
                draw2++;
                total2++;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Draw",draw2);
                updateQuery2.setUpdateColumn("Total_Points",total2);
                per.update((UpdateQuery)updateQuery2);










            }
            else if(value==2)
            {
                matchesrow.set("Winner",b);
                matchesrow.set("Runner",a);
                matchesrow.set("Draw",false);   
                

                //updating team_points_table for team1

                no_matches1++;
                loss1++;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Loss",loss1);
                per.update((UpdateQuery)updateQuery1);


                //updating team_points_table for team2
                no_matches2++;
                win2++;
                total2=total2+3;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Win",win2);
                updateQuery2.setUpdateColumn("Total_Points",total2);
                per.update((UpdateQuery)updateQuery2);








            }
            else if(value==1)
            {
                matchesrow.set("Winner",a);
                matchesrow.set("Runner",b);
                matchesrow.set("Draw",false); 


                //updating team_points_table for team1
                no_matches1++;
                win1++;
                total1=total1+3;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Win",win1);
                updateQuery1.setUpdateColumn("Total_Points",total1);
                per.update((UpdateQuery)updateQuery1);

                //updating team_points_table for team2
                no_matches2++;
                loss2++;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Loss",loss2);
                per.update((UpdateQuery)updateQuery2);


            }

            dataobject.addRow(matchesrow);
            per.add(dataobject);










            start.add(Calendar.DATE, 1);
            date = start.getTime();

        }

        //2nd set of matches


        for (ind=0; ind<matches.size() ;ind++)
         {

            String[] str=matches.get(ind).split("-");
            int a=Integer.parseInt(str[0]);
            int b=Integer.parseInt(str[1]);


            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");   
            String strDate = dateFormat.format(date);   

           
             Date Adate = dateFormat.parse(strDate);

            value=randomGenerator.nextInt(3) + 1;

            //sout.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+value);
            System.out.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+randomGenerator.nextInt(3) + 1);

            
            Table table_venue=new Table(table1);
            SelectQueryImpl squery2=new SelectQueryImpl(table_venue);
            Column column2=new Column(table1,"*");
            Criteria criteria2=new Criteria(new Column(table1,"Team_ID"),b,0);
            squery2.addSelectColumn(column1);
            squery2.setCriteria(criteria2);
            dataobject = per.get((SelectQuery)squery2);

            Row row=dataobject.getFirstRow(table1);

            String venue=(String) row.get(4);


            out.println("Date: " + strDate+" Matches:  "+a+" - "+b+" RandomValues:  "+value+"  venue:  "+venue);


            //updating data in the matches table
            dataobject=new WritableDataObject();
            Row matchesrow=new Row(table2);

            matchesrow.set("Team1",a);
            matchesrow.set("Team2",b);
            matchesrow.set("Date",Adate);
            matchesrow.set("Venue",venue);
            

            //updating team_points_table
            Table points_table=new Table(table3);
            DataObject dataobject_team1,dataobject_team2;
            int no_matches1,win1,loss1,draw1,total1;
            int no_matches2,win2,loss2,draw2,total2;



             //team_points_table for 1st team
             SelectQueryImpl squery3=new SelectQueryImpl(points_table);
             Column column3=new Column(table3,"*");
             Criteria criteria_va3=new Criteria(new Column(table3,"Team_ID"),a,0);
             squery3.addSelectColumn(column3);
             squery3.setCriteria(criteria_va3);
             dataobject_team1= per.get((SelectQuery)squery3);
             Row team_row1=dataobject_team1.getFirstRow(table3);
             no_matches1=(int) team_row1.get(3);
             win1=(int) team_row1.get(4);
             loss1=(int) team_row1.get(5);
             draw1=(int) team_row1.get(6);
             total1=(int) team_row1.get(7);

             System.out.println("Hello");



        
            //team_points_table for 2nd team
            SelectQueryImpl squery4=new SelectQueryImpl(points_table);
            Column column4=new Column(table3,"*");
            Criteria criteria_vb3=new Criteria(new Column(table3,"Team_ID"),b,0);
            squery4.addSelectColumn(column4);
            squery4.setCriteria(criteria_vb3);
            dataobject_team2= per.get((SelectQuery)squery4);
            Row team_row2=dataobject_team2.getFirstRow(table3);
            no_matches2=(int) team_row2.get(3);
            win2=(int) team_row2.get(4);
            loss2=(int) team_row2.get(5);
            draw2=(int) team_row2.get(6);
            total2=(int) team_row2.get(7);

           




            if(value==3)
            {
                matchesrow.set("Winner",0);
                matchesrow.set("Runner",0);
                matchesrow.set("Draw",true);    
                
               

                //updating team_points_table for team1
                no_matches1++;
                draw1++;
                total1++;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Draw",draw1);
                updateQuery1.setUpdateColumn("Total_Points",total1);
                per.update((UpdateQuery)updateQuery1);


                //updating team_points_table for team2
                no_matches2++;
                draw2++;
                total2++;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Draw",draw2);
                updateQuery2.setUpdateColumn("Total_Points",total2);
                per.update((UpdateQuery)updateQuery2);










            }
            else if(value==2)
            {
                matchesrow.set("Winner",b);
                matchesrow.set("Runner",a);
                matchesrow.set("Draw",false);   
                

                //updating team_points_table for team1

                no_matches1++;
                loss1++;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Loss",loss1);
                per.update((UpdateQuery)updateQuery1);


                //updating team_points_table for team2
                no_matches2++;
                win2++;
                total2=total2+3;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Win",win2);
                updateQuery2.setUpdateColumn("Total_Points",total2);
                per.update((UpdateQuery)updateQuery2);








            }
            else if(value==1)
            {
                matchesrow.set("Winner",a);
                matchesrow.set("Runner",b);
                matchesrow.set("Draw",false); 


                //updating team_points_table for team1
                no_matches1++;
                win1++;
                total1=total1+3;
                UpdateQueryImpl updateQuery1=new UpdateQueryImpl(table3);
                updateQuery1.setCriteria(criteria_va3);
                updateQuery1.setUpdateColumn("No_Of_Matches",no_matches1);
                updateQuery1.setUpdateColumn("Win",win1);
                updateQuery1.setUpdateColumn("Total_Points",total1);
                per.update((UpdateQuery)updateQuery1);

                //updating team_points_table for team2
                no_matches2++;
                loss2++;
                UpdateQueryImpl updateQuery2=new UpdateQueryImpl(table3);
                updateQuery2.setCriteria(criteria_vb3);
                updateQuery2.setUpdateColumn("No_Of_Matches",no_matches2);
                updateQuery2.setUpdateColumn("Loss",loss2);
                per.update((UpdateQuery)updateQuery2);


            }

            dataobject.addRow(matchesrow);
            per.add(dataobject);










            start.add(Calendar.DATE, 1);
            date = start.getTime();

        }


    
    


     
            

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }



    }

}