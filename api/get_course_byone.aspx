<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int courseId = int.Parse(Util.GetSafeRequestValue(Request, "courseid", "1"));
        Course course = new Course(courseId);
        string itemJson = Util.ConvertDataTableToJsonItemArray(course._fields.Table)[0];
        itemJson = itemJson.Replace("{", "{\"status\": 0, ");
        Response.Write(itemJson.Trim());
    }
</script>