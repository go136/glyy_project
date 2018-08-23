<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/json";
        if (Util.GetSafeRequestValue(Request, "sandbox", "0").Trim().Equals("1"))
        {

            Response.Write("{\"status\": 0, \"lessons\": ["
                + "{\"id\": 1, \"title\": \"第一课\", \"description\": \"内容内容balabala\", \"head_image\": \"http://www.abc.com/lesson1.jpg\", \"short_content\": \"balabala\", \"short_image\": \"http://www.abc.com/short_img.jpg\", \"sort\": 0, \"show\": 1}"
                + "]}");

        }
        else
        {
            int courseId = int.Parse(Util.GetSafeRequestValue(Request, "courseid", "3"));
            Lesson[] lessonArray = Course.GetLessons(courseId);
            /*
            DataRow[] drArr = new DataRow[lessonArray.Length];
            for (int i = 0; i < drArr.Length; i++)
            {
                drArr[i] = lessonArray[i]._fields;
            }
            string[] itemJsonArr = Util.ConvertDataTableToJsonItemArray(Util.AssembleDataRowToTable(drArr));
            */
            string json = "{\"status\": 0, \"lessons\": [";
            for (int i = 0; i < lessonArray.Length; i++)
            {
                json = json + (i > 0 ? ", " : "") + lessonArray[i].json.Trim();
            }
            Response.Write(json+"]}");
        }
    }
</script>