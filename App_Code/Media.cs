using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Media
/// </summary>
public class Media
{

    public DataRow _fields;

    public Media()
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
            return json;
        }

    }

    public static Media[] GetMedia(int lessonId)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from media where lesson_id = " + lessonId.ToString() + " order by sort, [id] ");
        Media[] mediaArray = new Media[dt.Rows.Count];
        for (int i = 0; i < mediaArray.Length; i++)
        {
            mediaArray[i] = new Media();
            mediaArray[i]._fields = dt.Rows[i];
        }
        return mediaArray;
    }
}