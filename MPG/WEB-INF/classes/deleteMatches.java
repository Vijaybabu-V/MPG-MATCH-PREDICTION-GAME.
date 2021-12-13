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

public class deleteMatches extends HttpServlet
{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {

        int mid=Integer.parseInt(request.getParameter("mid"));
        int prd=Integer.parseInt(request.getParameter("prd"));

        System.out.println("MATCH ID:  "+mid);
        System.out.println("PREDICTION:  "+prd);
       
        HttpSession session=request.getSession();
        int ID=(int)session.getAttribute("ID");




        try {


        Persistence per = (Persistence)BeanUtil.lookup("Persistence");
        DataObject data;
        SelectQueryImpl squery=new SelectQueryImpl(new Table("matches"));
        Criteria criteria1=new Criteria(new Column("matches","Match_ID"),mid,QueryConstants.EQUAL);
        squery.addSelectColumn(Column.getColumn("matches","*"));
        squery.setCriteria(criteria1);
        data=per.get((SelectQuery)squery);
        Row row1=data.getFirstRow("matches");
        int winner=(int)row1.get(4);
        boolean draw=(boolean)row1.get(6);

       
        data=null;
        SelectQueryImpl squery1=new SelectQueryImpl(new Table("user_points_table"));
        Criteria criteria2=new Criteria(new Column("user_points_table","User_ID"),ID,QueryConstants.EQUAL);
        squery1.addSelectColumn(Column.getColumn("user_points_table","*"));
        squery1.setCriteria(criteria2);
        data=per.get((SelectQuery)squery1);
        Row point_row=data.getFirstRow("user_points_table");
        int no_matches=(int)point_row.get(3);
        int win=(int)point_row.get(4);
        int loss=(int)point_row.get(5);
        int total=(int)point_row.get(6);



        
        System.out.println("Winner:    "+winner+"   Draw:    "+draw);
        data=new WritableDataObject();
        Row row3=new Row("prediction");
        row3.set("Match_ID",mid);
        row3.set("User_ID",ID);
        if(draw==true && prd==-1)
        {

             no_matches++;
             win++;
             total=total+3;

             UpdateQueryImpl updateQuery1=new UpdateQueryImpl("user_points_table");
             updateQuery1.setCriteria(criteria2);
             updateQuery1.setUpdateColumn("No_Of_Matches",no_matches);
             updateQuery1.setUpdateColumn("Win",win);
             updateQuery1.setUpdateColumn("Loss",loss);
             updateQuery1.setUpdateColumn("Total_Points",total);
             per.update((UpdateQuery)updateQuery1);





            










            row3.set("User_Prediction","DRAW");


           





            

        }
        else if(winner==prd)
        {
            no_matches++;
            win++;
            total=total+3;

            UpdateQueryImpl updateQuery2=new UpdateQueryImpl("user_points_table");
            updateQuery2.setCriteria(criteria2);
            updateQuery2.setUpdateColumn("No_Of_Matches",no_matches);
            updateQuery2.setUpdateColumn("Win",win);
            updateQuery2.setUpdateColumn("Loss",loss);
            updateQuery2.setUpdateColumn("Total_Points",total);
            per.update((UpdateQuery)updateQuery2);











            row3.set("User_Prediction","WIN");





        }
        else
        {

            no_matches++;
            loss++;

            UpdateQueryImpl updateQuery3=new UpdateQueryImpl("user_points_table");
            updateQuery3.setCriteria(criteria2);
            updateQuery3.setUpdateColumn("No_Of_Matches",no_matches);
            updateQuery3.setUpdateColumn("Win",win);
            updateQuery3.setUpdateColumn("Loss",loss);
            updateQuery3.setUpdateColumn("Total_Points",total);
            per.update((UpdateQuery)updateQuery3);








            row3.set("User_Prediction","LOSS");

        }


        data.addRow(row3);
        per.add(data);
         

            
           

      
      

        }
        catch (Exception e) {
            e.printStackTrace();
        }











    }







}