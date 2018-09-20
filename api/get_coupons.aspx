<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "");
        string openId = WeixinUser.CheckToken(token.Trim());
        if (openId.Trim().Equals(""))
        {
            Response.Write("{\"token_is_valid\": 0}");
        }
        else
        {
            Response.Write("{\"token_is_valid\": 1, \"coupons\": []}");
        }
    }
</script>