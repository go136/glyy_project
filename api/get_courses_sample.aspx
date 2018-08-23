<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.AddHeader("Access-Control-Allow-Origin", "*");
        Response.ContentType = "application/json";
        if (Util.GetSafeRequestValue(Request, "sandbox", "0").Trim().Equals("1"))
        {
            Response.Write("{\"status\": 0, \"courses\":["
                + "{\"id\": 1, \"title\": \"英语阅读入门\", \"description\": \"学期介绍介绍介绍balabala\", \"head_image\": \"http://www.abc.com/xxx.jpg\", \"sort\": \"美食篇\", \"level\": \"入门\", \"teacher\": \"Tom Cat\", \"order\": 10},"
                + "{\"id\": 2, \"title\": \"英语阅读提高\", \"description\": \"发现狂野澳洲\", \"head_image\": \"http://www.abc.com/yyy.jpg\", \"sort\": \"户外篇\", \"level\": \"提高\", \"teacher\": \"Mickey Mouse\", \"order\": 20}"
                + "]}");
        }
        else
        {
            string sort = Util.GetSafeRequestValue(Request, "sort", "").Trim();
            string level = Util.GetSafeRequestValue(Request, "level", "").Trim();
            string teacher = Util.GetSafeRequestValue(Request, "teacher", "").Trim();
            Course[] courseAllArray = Course.GetAllCourses();
            string itemsJson = "";
            for (int i = 0; i < courseAllArray.Length; i++)
            {
                if (courseAllArray[i].Price == 0 && courseAllArray[i].Show == 1)
                {
                    if (!sort.Equals("") && !courseAllArray[i]._fields["sort"].ToString().Trim().Equals(sort))
                    {
                        continue;
                    }
                    if (!level.Equals("") && !courseAllArray[i]._fields["level"].ToString().Trim().Equals(level))
                    {
                        continue;
                    }
                    if (!teacher.Trim().Equals("") && !courseAllArray[i]._fields["teacher"].ToString().Trim().Equals(teacher))
                    {
                        continue;
                    }
                    string itemJson = "";
                    foreach (DataColumn c in courseAllArray[i]._fields.Table.Columns)
                    {
                        if (!itemJson.Trim().Equals(""))
                        {
                            itemJson = itemJson + ",";
                        }
                        itemJson = itemJson + "\"" + c.Caption.Trim() + "\": \"" + courseAllArray[i]._fields[c].ToString().Trim() + "\"";
                    }
                    if (!itemsJson.Trim().Equals(""))
                    {
                        itemsJson = itemsJson + ",";
                    }
                    itemsJson = itemsJson + "{" + itemJson.Trim() + "}";
                }
            }
            Response.Write("{\"status\": 0, \"courses\":[" + itemsJson.Trim() + "]}");
        }

    }
</script>