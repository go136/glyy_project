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

    public OnlineOrder()
    {

    }

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

    public void Cancel()
    {
        DBHelper.UpdateData("orders", new string[,] { { "state", "int", "3" }, { "valid", "int", "0" } },
            new string[,] { { "id", "int", _fields["id"].ToString() } }, Util.conStr);
  
    }

    public void SetPayTime(DateTime payTime)
    {
        DBHelper.UpdateData("orders", new string[,] { { "state", "int", "1" }, { "pay_time", "datetime", payTime.ToString() } },
            new string[,] { { "id", "int", _fields["id"].ToString() } }, Util.conStr);
    }

    public void SetPaySuccess(DateTime paySuccessTime)
    {
        DBHelper.UpdateData("orders", new string[,] { { "state", "int", "2" }, { "pay_success_time", "datetime", paySuccessTime.ToString() } },
            new string[,] { { "id", "int", _fields["id"].ToString() } }, Util.conStr);
    }

    public static OnlineOrder[] GetOrders(string openId)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from orders where owner = '" + openId.Trim().Replace("'", "").Trim() + "' order by [id] desc ");
        OnlineOrder[] orderArray = new OnlineOrder[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            orderArray[i] = new OnlineOrder();
            orderArray[i]._fields = dt.Rows[i];
        }
        return orderArray;
    }


    public static OnlineOrder GetLastCourseOrder(string openId)
    {
        DataTable dt = DBHelper.GetDataTable(" select top 1 * from orders where state = 2 and valid = 1 and owner =  '" + openId.Replace("'", "") + "' order by [id] desc");
        OnlineOrder order = new OnlineOrder();
        if (dt.Rows.Count > 0)
        {
            order._fields = dt.Rows[0];
        }
        return order;
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
                        {"end_date", "datetime", orderDate.AddHours(1).ToString() }
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


    public static OnlineOrder[] GetOutTimeOrders()
    {
        DataTable dt = DBHelper.GetDataTable(" select * from orders where end_date > '" + DateTime.Now + "' ");
        OnlineOrder[] orderArr = new OnlineOrder[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            orderArr[i] = new OnlineOrder();
            orderArr[i]._fields = dt.Rows[i];
        }
        return orderArr;
    }

}