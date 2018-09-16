<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>

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
            DataTable dt = DBHelper.GetDataTable("select distinct course_id from orders where state = 2 and owner = '" + openId.Trim() + "' ");
            string ret = "";
            foreach (DataRow dr in dt.Rows)
            {
                ret = ret + (ret.Trim().Equals("") ? "" : ",") + dr[0].ToString().Trim();
            }
            dt.Dispose();
            Response.Write("{\"token_is_valid\": 0, \"order_courses\": \"" + ret.Trim() + "\"}");
        }
    }
</script>
