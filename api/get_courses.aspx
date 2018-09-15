<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">



    protected void Page_Load(object sender, EventArgs e)
    {
        string sort = Util.GetSafeRequestValue(Request, "sort", "");
        string level = Util.GetSafeRequestValue(Request, "level", "");
        string teacher = Util.GetSafeRequestValue(Request, "teacher", "");

        string filter = "";
        if (!sort.Trim().Equals(""))
        {
            filter = ((filter.Trim().Equals("")) ? " " : " and ") + " sort = '" + sort + "' ";
        }
        if (!level.Trim().Equals(""))
        {
            filter = ((filter.Trim().Equals("")) ? " " : " and ") + " level = '" + level + "' ";
        }
        if (!teacher.Trim().Equals(""))
        {
            filter = ((filter.Trim().Equals("")) ? " " : " and ") + " teacher = '" + teacher + "' ";
        }

        if (!filter.Trim().Equals(""))
        {
            filter = " where " + filter.Trim();
        }
        DataTable dt = DBHelper.GetDataTable(" select * from course " + filter.Trim());
        

    }
</script>