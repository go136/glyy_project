<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        string token = Util.GetSafeRequestValue(Request, "token", "2ae547f99b95e6c30e9c17d8d6fce51df5850b221cb97b9337702ff70189061a1b375982");
        string openId = WeixinUser.CheckToken(token);
        Course[] courseArr = Course.GetCoursesForOnPerson(openId);
        int newCourseId = 0;
        if (courseArr.Length > 0)
        {
            newCourseId = int.Parse(courseArr[courseArr.Length - 1]._fields["next_package"].ToString());
            DataTable dt = DBHelper.GetDataTable("select * from course where [id] = " + newCourseId.ToString());
            if (dt.Rows.Count > 0)
            {
                Response.Write("{\"status\":0, \"courses\": [" + Util.ConvertDataTableToJsonItemArray(dt)[0].Trim() + "]}");
            }
            else
            {
                if (newCourseId != 0)
                {
                    Response.Write("{\"status\":0, \"courses\": []}");
                }
            }
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