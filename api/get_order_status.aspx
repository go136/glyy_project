<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "f48abff6f296f151f55fec058824a6c261517876e5cc15465edd12244f114830445af7ce");
        int orderId = int.Parse(Util.GetSafeRequestValue(Request, "orderid", "9"));
        string openId = WeixinUser.CheckToken(token.Trim());
        OnlineOrder order = new OnlineOrder(orderId);
        if (order._fields == null)
        {
            Response.Write("{\"msg\": \"The order is not exists.\"}");
            Response.End();
        }
        if (openId.Trim().Equals(order._fields["owner"].ToString().Trim()))
        {
            string itemJson = Util.ConvertDataTableToJsonItemArray(order._fields.Table)[0];
            Response.Write("{\"token_is_valid\": 1, \"order_status\": " + itemJson.Trim() + " }");
        }
        else
        {
            Response.Write("{\"token_is_valid\": 0}");
        }
    }
</script>
