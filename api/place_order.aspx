<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "8aa2e9a7a63d0650eee5b99b5be8dcd4bf83d08b9fa774e518b9c40d467c42c14ceb0c43");
        string ticketCode = Util.GetSafeRequestValue(Request, "ticket_code", "0").Trim();
        int courseId = int.Parse(Util.GetSafeRequestValue(Request, "course_id", "2"));
        string openId = WeixinUser.CheckToken(token.Trim());
        if (!openId.Trim().Equals(""))
        {
            int orderId = OnlineOrder.PlaceOrder(openId.Trim(), courseId, DateTime.Now, int.Parse(ticketCode.Trim()));
            //OnlineOrder order = new OnlineOrder(o)
            if (orderId > 0)
            {
                OnlineOrder order = new OnlineOrder(orderId);
                Response.Write("{\"token_is_valid\": 0, \"order_id\": " + orderId.ToString() + ", \"amount\": " + Math.Round(double.Parse(order._fields["total_amount"].ToString()), 2).ToString() 
                    + ", \"real_pay_amount\": " + Math.Round(double.Parse(order._fields["real_pay"].ToString()), 2).ToString() + " }");
            }
            else
            {
                Response.Write("{\"token_is_valid\": 0, \"order_id\": " + orderId.ToString() + "}");

            }
        }
        else
        {
            Response.Write("{\"token_is_valid\": 0, \"order_id\": -1}");
        }
    }
</script>