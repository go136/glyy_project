<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "c7adf76d2bba2edacf12af972849a870120ce63ea466437f737a79ec21f4bd5a13262cca");
        string openId = WeixinUser.CheckToken(token);
        int orderId = int.Parse(Util.GetSafeRequestValue(Request, "orderid", "2"));
        if (openId.Trim().Equals(""))
        {
            Response.Write("{\"token_is_valid\": 0}");
            Response.End();
        }
        OnlineOrder order = new OnlineOrder(orderId);
        if (!order._fields["owner"].ToString().Trim().Equals(openId))
        {
            Response.Write("{\"token_is_valid\": 1, \"cancel_status\": 0}");
            Response.End();
        }
        order.Cancel();
        Response.Write("{\"token_is_valid\": 1, \"cancel_status\": 1}");
    }
</script>