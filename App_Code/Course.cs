using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Course
/// </summary>
public class Course
{
    public DataRow _fields;

    public Course()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public double Price
    {
        get
        {
            return double.Parse(_fields["price"].ToString().Trim());
        }
    }

    public int Show
    {
        get
        {
            return int.Parse(_fields["show"].ToString().Trim());
        }
    }

    public string json
    {
        get
        {
            return Util.ConvertDataTableToJsonItemArray(Util.AssembleDataRowToTable(new DataRow[] { _fields }))[0].Trim();
        }

    }

    public static Course[] GetAllCourses()
    {
        DataTable dt = DBHelper.GetDataTable(" select * from course ");
        Course[] cArr = new Course[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            cArr[i] = new Course();
            cArr[i]._fields = dt.Rows[i];
        }
        return cArr;
    }

    public static Lesson[] GetLessons(int courseId)
    {
        DataTable dt = DBHelper.GetDataTable(" select * from lesson where course_id = " + courseId + "  order by sort, [id] ");
        Lesson[] lessonArray = new Lesson[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {

            lessonArray[i] = new Lesson();
            lessonArray[i]._fields = dt.Rows[i];
        }
        return lessonArray;
    }

    
}