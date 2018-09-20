<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "8aa2e9a7a63d0650eee5b99b5be8dcd4bf83d08b9fa774e518b9c40d467c42c14ceb0c43");
        int orderId = int.Parse(Util.GetSafeRequestValue(Request, "orderid", "9"));
        string openId = WeixinUser.CheckToken(token.Trim());
        OnlineOrder order = new OnlineOrder(orderId);
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
