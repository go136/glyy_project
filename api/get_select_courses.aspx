<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "");
        string openId = WeixinUser.CheckToken(token);
        Course[] courseArr = Course.GetCoursesForOnPerson(openId);
        int newCourseId = 0;
        if (courseArr.Length > 0)
        {
            newCourseId = int.Parse(courseArr[courseArr.Length - 1]._fields["next_package"].ToString());
            DataTable dt = DBHelper.GetDataTable("select * from course where [id] = " + newCourseId.ToString());
            Response.Write("{\"status\":0, courses:[" + Util.ConvertDataTableToJsonItemArray(dt)[0].Trim() + "]}");
        }
        if (newCourseId == 0)
        {
            string sort = Util.GetSafeRequestValue(Request, "sort", "");
            string teacher = Util.GetSafeRequestValue(Request, "teacher", "");
            string level = Util.GetSafeRequestValue(Request, "level", "");

            string filter = "";
            if (!sort.Trim().Equals(""))
            {
                filter = filter + ((filter.Trim().Equals("")) ? " " : " and ") + " sort = '" + sort + "' ";
            }
            if (!level.Trim().Equals(""))
            {
                filter = filter + ((filter.Trim().Equals("")) ? " " : " and ") + " level = '" + level + "' ";
            }
            if (!teacher.Trim().Equals(""))
            {
                filter = filter + ((filter.Trim().Equals("")) ? " " : " and ") + " teacher = '" + teacher + "' ";
            }

            if (!filter.Trim().Equals(""))
            {
                filter = " where " + filter.Trim();
            }
            DataTable dt = DBHelper.GetDataTable(" select * from course " + filter.Trim());
            string[] itemJsonArr = Util.ConvertDataTableToJsonItemArray(dt);
            //string ret = "{\"status\": 0, }";
            string itemJson = "";
            foreach (string s in itemJsonArr)
            {
                itemJson = itemJson + (itemJson.Trim().Equals("") ? "" : ", ") + s;
            }
            Response.Write("{\"status\": 0, \"courses\":[" + itemJson.Trim() + "]}");
        }
    }
</script>