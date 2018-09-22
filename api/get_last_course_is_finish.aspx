<%@ Page Language="C#" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "");
        string openId = WeixinUser.CheckToken(token);
        if (openId.Trim().Equals(""))
        {
            Response.Write("{\"token_is_valid\": 0}");
            Response.End();
        }
        try
        {
            OnlineOrder order = OnlineOrder.GetLastCourseOrder(openId);
            Course course = new Course(int.Parse(order._fields["course_id"].ToString()));
            bool isFinish = false;
            if (DateTime.Now > DateTime.Parse(order._fields["pay_success_time"].ToString()).AddDays(int.Parse(course._fields["cost_days"].ToString()))
                .AddDays(int.Parse(course._fields["gap_days"].ToString())))
            {
                isFinish = true;
            }
            Response.Write("{\"token_is_valid\": 1, \"course_id\": " + course._fields["id"].ToString() + ", \"order_id\": " + order._fields["id"].ToString() + ", \"is_finish\": \"" + isFinish.ToString() + "\" }");
        }
        catch
        {
            bool isFinish = true;
            Response.Write("{\"token_is_valid\": 1, \"is_finish\": \"" + isFinish.ToString() + "\" }");
        }
    }
</script>