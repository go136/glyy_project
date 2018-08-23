using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Handout
/// </summary>
public class Handout
{
    public DataRow _fields;

    public Handout()
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

    public static Media[] GetMedia(int handoutId)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from media where handout_id = " + handoutId.ToString() + " order by sort, [id] ");
        Media[] mediaArray = new Media[dt.Rows.Count];
        for (int i = 0; i < mediaArray.Length; i++)
        {
            mediaArray[i] = new Media();
            mediaArray[i]._fields = dt.Rows[i];
        }
        return mediaArray;
    }
}