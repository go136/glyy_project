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
}