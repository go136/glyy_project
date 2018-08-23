<%@ Page Language="C#" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string openId = WeixinUser.CheckToken(Util.GetSafeRequestValue(Request,"usertoken",""));
        string type = Util.GetSafeRequestValue(Request, "type", "");
        string logId = Util.GetSafeRequestValue(Request, "logid", "");
        long timeStamp = long.Parse(Util.GetSafeRequestValue(Request, "timestamp", "0").Trim());
        if (!openId.Trim().Equals("") && !type.Trim().Equals("") && !logId.Trim().Equals("") && timeStamp > 0)
        {
            try
            {
                DBHelper.InsertData("user_activity_log", new string[,] {
                    {"open_id", "varchar", openId.Trim() },
                    {"time_stamp", "bigint",timeStamp.ToString() },
                    {"log_id", "varchar", logId.Trim() },
                    {"type", "varchar", type.Trim() }
                });
            }
            catch
            {

            }
        }
    }
</script>