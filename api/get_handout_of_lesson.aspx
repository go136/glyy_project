<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "application/json";
        if (Util.GetSafeRequestValue(Request, "sandbox", "0").Trim().Equals("1"))
        {
            Response.Write("{\"status\": 0, \"token_is_valid\": 1, \"sections\": [" +
                "{\"type\": \"重点单词\", \"english_content\": \"watch\", \"chinese_content\": \"手表，观看\", \"sort\": 10, \"english_keyword\": \"watch\", \"chinese_keyword\": \"手表\"},"
                + "{\"type\": \"重点句型\", \"english_content\": \"Drills List\", \"chinese_content\": \"中文内容\", \"sort\": 20, \"english_keyword\": \"\", \"chinese_keyword\": \"\", \"medias\": ["
                + "{\"id\": 1, \"type\": \"audio\", \"media_url\": \"http://www.abc.com/xxx.mp3\", \"caption_file_url\": \"http://www.abc.com/caption_xxx.txt\", \"sort\": 10},"
                + "{\"id\": 2, \"type\": \"video\", \"media_url\": \"http://www.abc.com/xxx.mp4\", \"caption_file_url\": \"http://www.abc.com/caption2_xxx.txt\", \"sort\": 20}"
                + "] }"

                + "]}");
        }
        else
        {
            int lessonId = int.Parse(Util.GetSafeRequestValue(Request, "lessonid", "1"));

            string type = Util.GetSafeRequestValue(Request, "type", "");

            Handout[] handoutArray = Lesson.GetHandouts(lessonId, type);

            /*
            DataRow[] drArr = new DataRow[handoutArray.Length];
            for (int i = 0; i < drArr.Length; i++)
            {
                drArr[i] = handoutArray[i]._fields;
            }
            */
            //string[] itemJsonArr = Util.ConvertDataTableToJsonItemArray(Util.AssembleDataRowToTable(drArr));

            string json = "{\"status\": 0, \"handouts\": [";
            
            for (int i = 0; i < handoutArray.Length; i++)
            {
                json = json + (i > 0 ? ", " : "") + handoutArray[i].json.Trim();
            }
            
            /*
            for (int i = 0; i < 11; i++)
            {
                json = json + (i > 0 ? ", " : "") + handoutArray[i].json.Trim().Replace("'","");
            }
            */
            Response.Write(json+"]}");
        }
    }
</script>