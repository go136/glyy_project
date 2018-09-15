<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int courseId = int.Parse(Util.GetSafeRequestValue(Request, "courseid", "1"));
        Course course = new Course(courseId);
        Response.Write("{\"info\":[{\"course_id\": " + courseId.ToString() + ", \"price\": " 
            + Math.Round(double.Parse(course._fields["price"].ToString()), 2).ToString() + ", \"discount\": 0, \"discount_end_time\": \"2999-1-1\"}]}");
    }
</script>
