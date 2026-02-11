using System;

public class DBNotNull 
{
    /// <summary>
    /// if the database field [dbItem] is null, "" will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or String</param>
    /// <returns>String</returns>
 public static string DBNotNullStr(object dbItem) { return DBNotNullStr(dbItem, ""); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or String</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>String</returns>
 public static string DBNotNullStr(object dbItem, string defaultVal) 
 {
   DateTime temp;
   if (Convert.IsDBNull(dbItem))  
     return defaultVal; 
    else if (DateTime.TryParse(dbItem.ToString(),out temp)) 
     return temp.ToString(); 
    else 
     return dbItem.ToString();    
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [false] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or bool</param>
    /// <returns>String</returns>
 public static bool DBNotNullBool(object dbItem) { return DBNotNullBool(dbItem, false); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or bool</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>String</returns>
 public static bool DBNotNullBool(object dbItem, bool defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem))
     return defaultVal; 
   else 
     try {
       return Convert.ToBoolean(dbItem); 
     } catch {
       return defaultVal;
     }   
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or int</param>
    /// <returns>int</returns>
 public static int DBNotNullInt(object dbItem) { return DBNotNullInt(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or int</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static int DBNotNullInt(object dbItem, int defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem)) 
     return defaultVal; 
   else
     try {
         return (int)Convert.ToInt16(dbItem);
     } catch {
         return defaultVal;
     }       
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <returns>int</returns>
 public static long DBNotNullLng(object dbItem) { return DBNotNullLng(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static long DBNotNullLng(object dbItem, long defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem))
     return defaultVal; 
   else
     try {
         return (long)dbItem;
     } catch {
         return defaultVal;
     }
} 

    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or single</param>
    /// <returns>int</returns>
 public static Single DBNotNullSingle(object dbItem)  { return DBNotNullSingle(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or single</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static Single DBNotNullSingle(object dbItem, Single defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem))
     return defaultVal; 
   else
     try { 
       return Convert.ToSingle(dbItem); 
     } catch { 
       return defaultVal; 
     } 
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or double</param>
    /// <returns>int</returns>
 public static double DBNotNullDouble(object dbItem)   { return DBNotNullDouble(dbItem, 0.0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or double</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static double DBNotNullDouble(object dbItem, double dblDefault) 
 { 
   if (Convert.IsDBNull(dbItem))
     return dblDefault; 
   else
     try { 
       return Convert.ToDouble(dbItem); 
     } catch { 
       return dblDefault; 
     } 
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or decimal</param>
    /// <returns>int</returns>
 public static decimal DBNotNullDec(object dbItem)   { return DBNotNullDec(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or decimal</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static decimal DBNotNullDec(object dbItem, decimal defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem))
     return defaultVal; 
   else
     try { 
       return Convert.ToDecimal(dbItem); 
     } catch { 
       return defaultVal; 
     } 
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date</param>
    /// <returns>int</returns>
 public static System.DateTime DBNotNullDate(object dbItem)  { return DBNotNullDate(dbItem, DateTime.MinValue); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static System.DateTime DBNotNullDate(object dbItem, System.DateTime defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem))
     return defaultVal; 
   else 
     try { 
       return Convert.ToDateTime(dbItem); 
     } catch { 
       return defaultVal; 
     }     
 } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date</param>
    /// <returns>int</returns>
 public static string DBNotNullDateStr(object dbItem) { return DBNotNullDate(dbItem, "", ""); }
 public static string DBNotNullDate(object dbItem, string format) { return DBNotNullDate(dbItem, format, ""); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>int</returns>
 public static string DBNotNullDate(object dbItem, string format, string defaultVal) 
 { 
   if (Convert.IsDBNull(dbItem)) 
     return defaultVal; 
   else 
     try {
         if (format == "")
             return Convert.ToDateTime(dbItem).ToString();
         else
             return Convert.ToDateTime(dbItem).ToString(format); 
     } catch { 
       return defaultVal; 
     }     
 } 
}