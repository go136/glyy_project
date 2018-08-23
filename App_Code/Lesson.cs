using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Lesson
/// </summary>
public class Lesson
{

    public DataRow _fields;

    public Lesson()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int id
    {
        get
        {
            return int.Parse(_fields["id"].ToString());
        }
    }

    public string json
    {
        get
        {
            string json = Util.ConvertDataTableToJsonItemArray(Util.AssembleDataRowToTable(new DataRow[] { _fields }))[0].Trim();
            json = json.Remove(json.Length - 1, 1) + ", \"medias\": [";
            Media[] mediaArray = GetMedia(id);
            string mediaJson = "";
            foreach (Media m in mediaArray)
            {
                if (!mediaJson.Trim().Equals(""))
                {
                    mediaJson = mediaJson + ", ";
                }
                mediaJson = mediaJson + m.json;
            }
            return json + mediaJson.Trim() + "]}";
        }

    }

    public static Handout[] GetHandouts(int lessonId, string type)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from handout where lesson_id = " + lessonId.ToString() + "   " +  ((!type.Trim().Equals(""))? " and [type] = '" + type.Trim() + "'  ": "")   + "  order by [type], sort, [id] ");
        Handout[] handoutArray = new Handout[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            handoutArray[i] = new Handout();
            handoutArray[i]._fields = dt.Rows[i];
        }
        return handoutArray;
    }

    public static Media[] GetMedia(int lessonId)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from media where lesson_id = " + lessonId.ToString() + " order by sort,[id] " );
        Media[] mediaArray = new Media[dt.Rows.Count];
        for (int i = 0; i < mediaArray.Length; i++)
        {
            mediaArray[i] = new Media();
            mediaArray[i]._fields = dt.Rows[i];
        }
        return mediaArray;
    }
}