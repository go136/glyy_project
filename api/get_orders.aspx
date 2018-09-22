<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "a3d06299cca3bbe7c3103fc4f3cbf8cc97cc2f2c3c13e0e1f694071748363fbc1bfde2b1");
        string openId = WeixinUser.CheckToken(token.Trim());
        if (openId.Trim().Equals(""))
        {
            Response.Write("{\"token_is_valid\": 0}");
            Response.End();
        }
        OnlineOrder[] orders = OnlineOrder.GetOrders(openId.Trim());
        string itemJson = "";
        if (orders.Length > 0)
        {
            string[] itemJsonArr = Util.ConvertDataTableToJsonItemArray(orders[0]._fields.Table);
            foreach (string tmp in itemJsonArr)
            {
                itemJson = itemJson + (itemJson.Trim().Equals("") ? "" : ",")
                    + tmp;
            }
        }
        Response.Write("{\"token_is_valid\": 1, \"orders\": [" + itemJson.Trim() + "]}");
    }
</script>