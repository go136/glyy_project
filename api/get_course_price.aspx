<%@ Page Language="C#" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        int courseId = int.Parse(Util.GetSafeRequestValue(Request, "courseid", "0"));
        Course course = new Course(courseId);
        //Response.Write("{")
    }
</script>
