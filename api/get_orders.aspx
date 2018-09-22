<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "246676db657db9b9bcf89c3d7672871be5ee398345314a308c2d3bd87ccc070a1d80ff39");
        string openId = WeixinUser.CheckToken(token.Trim());
        if (openId.Trim().Equals(""))
        {
            Response.Write("{\"token_is_valid\": 0}");
            Response.End();
        }
        OnlineOrder[] orders = OnlineOrder.GetOrders(openId.Trim());
        string itemJson = "";
        foreach (OnlineOrder order in orders)
        {
            itemJson = itemJson + (itemJson.Trim().Equals("") ? "" : ",")
                + Util.ConvertDataTableToJsonItemArray(order._fields.Table)[0].Trim();
        }
        Response.Write("{\"token_is_valid\": 1, \"orders\": [" + itemJson.Trim() + "]}");
    }
</script>