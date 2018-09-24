<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">

    public int orderId = 0;
    public string token = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        orderId = int.Parse(Util.GetSafeRequestValue(Request, "orderid", "0"));
        token = Util.GetSafeRequestValue(Request, "token", "");
        string openId = WeixinUser.CheckToken(token);
        OnlineOrder order = new OnlineOrder(orderId);
        Course course = new Course(int.Parse(order._fields["course_id"].ToString()));
        double realPay = double.Parse(order._fields["real_pay"].ToString().Trim());

        if (order._fields["owner"].ToString().Trim().Equals(openId))
        {
            Response.Redirect("payment.aspx?body=" + Server.UrlEncode(course._fields["title"].ToString().Trim())
                + "&detail=" + Server.UrlEncode(course._fields["description"].ToString().Trim())
                + "&product_id=" + orderId.ToString() + "&token=" + token.Trim()+"&total_fee=" + ((int)Math.Round(realPay * 100, 0)).ToString() );
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
