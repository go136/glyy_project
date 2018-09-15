using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for OnlineOrder
/// </summary>
public class OnlineOrder
{

    public DataRow _fields;

    public OnlineOrder(int orderId)
    {
        //
        // TODO: Add constructor logic here
        //

        DataTable dt = DBHelper.GetDataTable(" select * from orders where [id] = " + orderId.ToString());
        if (dt.Rows.Count == 1)
        {
            _fields = dt.Rows[0];
        }
    }

    public static int PlaceOrder(string openId, int courseId, DateTime orderDate, int ticketId)
    {
        int orderId = 0;
        DataTable dtCourseDuplicate = DBHelper.GetDataTable("  select * from orders where owner = '" + openId.Trim() + "' and [state] = 2 and course_id = " + courseId.ToString());

        if (dtCourseDuplicate.Rows.Count == 0)
        {

            dtCourseDuplicate.Dispose();
            dtCourseDuplicate = DBHelper.GetDataTable("  select * from orders where owner = '" + openId.Trim() + "' and [state] in (0, 1) and course_id = " + courseId.ToString());
            if (dtCourseDuplicate.Rows.Count == 0)
            {
                
                Course course = new Course(courseId);
                double totalAmount = course.GetPrice(openId, orderDate);
                double discountAmount = 0;
                double realPayAmount = totalAmount - discountAmount;
                if (orderId == 0)
                {
                    int i = DBHelper.InsertData("orders", new string[,]{
                        {"owner", "varchar", openId.Trim() },
                        {"course_id", "int", courseId.ToString()},
                        {"total_amount", "float",  totalAmount.ToString()},
                        {"ticket_id", "int", ticketId.ToString() },
                        {"ticket_discount_amount", "float", discountAmount.ToString() },
                        {"real_pay", "float", realPayAmount.ToString() },
                        {"end_date", "datetime", orderDate.AddHours(6).ToString() }
                    });
                    if (i == 1)
                    {
                        DataTable dtOrderId = DBHelper.GetDataTable(" select max([id]) from orders where owner = '" + openId.Trim() + "' ");
                        if (dtOrderId.Rows.Count == 1)
                        {
                            orderId = int.Parse(dtOrderId.Rows[0][0].ToString().Trim());

                        }
                        dtOrderId.Dispose();
                    }
                }
            }
            else
            {
                orderId = -4;
            }
        }
        else
        {
            orderId = -1;
        }
        dtCourseDuplicate.Dispose();
        return orderId;
    }
}