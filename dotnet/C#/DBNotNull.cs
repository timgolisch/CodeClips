using System;

public class DBNotNull
{
    #region Not Nullable
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
        if (Convert.IsDBNull(dbItem) || dbItem == null)  
            return defaultVal; 
        else 
            return dbItem.ToString();    
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [false] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or bool</param>
    /// <returns>bool</returns>
     public static bool DBNotNullBool(object dbItem) { return DBNotNullBool(dbItem, false); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or bool</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>bool</returns>
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
             return (int)Convert.ToInt32(dbItem);
         } catch {
             return defaultVal;
         }       
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <returns>long</returns>
    public static long DBNotNullLong(object dbItem) { return DBNotNullLong(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>long</returns>
    public static long DBNotNullLong(object dbItem, long defaultVal) 
    { 
       if (Convert.IsDBNull(dbItem)) 
         return defaultVal; 
       else
         try {
             return (long)Convert.ToInt64(dbItem);
         } catch {
             return defaultVal;
         }       
    }     /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte array</param>
    /// <returns>byte array</returns>
    public static byte[] DBNotNullBytes(object dbItem) { byte[] empty=null;  return DBNotNullBytes(dbItem, empty); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte array</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>byte array</returns>
    public static byte[] DBNotNullBytes(object dbItem, byte[] defaultVal) 
    { 
       if (Convert.IsDBNull(dbItem)) 
         return defaultVal; 
       else
         try {
             return (byte[]) dbItem;
         } catch {
             return defaultVal;
         }       
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <returns>long</returns>
    public static long DBNotNullLng(object dbItem) { return DBNotNullLng(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>long</returns>
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
    /// <returns>single</returns>
    public static Single DBNotNullSingle(object dbItem)  { return DBNotNullSingle(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or single</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>single</returns>
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
    /// <returns>double</returns>
    public static double DBNotNullDouble(object dbItem)   { return DBNotNullDouble(dbItem, 0.0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or double</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>double</returns>
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
    /// <param name="dbItem">the value from the database column.  usually a NULL or float</param>
    /// <returns>float</returns>
    public static float DBNotNullFloat(object dbItem)   { return DBNotNullFloat(dbItem, 0.0f); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or float</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>float</returns>
    public static float DBNotNullFloat(object dbItem, float dblDefault) 
    { 
           if (Convert.IsDBNull(dbItem))
             return dblDefault; 
           else
             try { 
               return (float)dbItem; 
             } catch (Exception ex) {
               ErrorHandling.ErrorLogger.LogException(ex, dbItem.ToString());
               try {
                   //this is probably horribly inefficient, but it is better than punting [TG]
                   return float.Parse(dbItem.ToString());
               } catch {
                   return dblDefault; 
               }
             } 
    } 
    
    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or decimal</param>
    /// <returns>decimal</returns>
    public static decimal DBNotNullDec(object dbItem)   { return DBNotNullDec(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or decimal</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>decimal</returns>
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
    /// <returns>System.DateTime</returns>
    public static System.DateTime DBNotNullDate(object dbItem)  { return DBNotNullDate(dbItem, DateTime.MinValue); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>System.DateTime</returns>
    public static System.DateTime DBNotNullDate(object dbItem, System.DateTime defaultVal) 
    { 
       if (Convert.IsDBNull(dbItem) || dbItem == null)
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
    /// <param name="dbItem">the value from the database column.  usually a NULL or timespan</param>
    /// <returns>System.TimeSpan</returns>
    public static System.TimeSpan DBNotNullTime(object dbItem)  { return DBNotNullTime(dbItem, TimeSpan.MinValue); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or timespan</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>System.TimeSpan</returns>
    public static System.TimeSpan DBNotNullTime(object dbItem, System.TimeSpan defaultVal) 
    { 
       if (Convert.IsDBNull(dbItem))
         return defaultVal; 
       else 
         try { 
           return TimeSpan.Parse(dbItem.ToString()); 
         } catch { 
           return defaultVal; 
         }     
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or (string)date</param>
    /// <returns>string</returns>
    public static string DBNotNullDateStr(object dbItem) { return DBNotNullDate(dbItem, "", ""); }
    public static string DBNotNullDate(object dbItem, string format) { return DBNotNullDate(dbItem, format, ""); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or (string)date</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>string</returns>
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
    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte</param>
    /// <returns>byte</returns>
    public static byte DBNotNullByte(object dbItem) { return DBNotNullByte(dbItem, 0); }
    /// <summary>
    /// if the database field [dbItem] is null, [defaultVal] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte</param>
    /// <param name="defaultVal">if [dbItem] is null, this val will be returned</param>
    /// <returns>byte</returns>
    public static byte DBNotNullByte(object dbItem, byte defaultVal)
    {
         if (Convert.IsDBNull(dbItem))
             return defaultVal;
         else
             try
             {
                 return (byte)Convert.ToByte(dbItem);
             }
             catch
             {
                 return defaultVal;
             }
     }  
    #endregion
    #region Nullable
    /// <summary>
    /// if the database field [dbItem] is null, "" will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or String</param>
    /// <returns>String</returns>
    public static string NullableStr(object dbItem)
    {
        DateTime temp;
        if (Convert.IsDBNull(dbItem))  
            return null; 
        else if (DateTime.TryParse(dbItem.ToString(),out temp)) 
            return temp.ToString(); 
        else 
            return dbItem.ToString();    
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [false] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or bool</param>
    /// <returns>bool</returns>
     public static Nullable<bool> NullableBool(object dbItem) 
    { 
        if (Convert.IsDBNull(dbItem))
            return null; 
        else 
            try {
                return Convert.ToBoolean(dbItem); 
            } catch {
                return null;
            }   
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or int</param>
    /// <returns>int</returns>
    public static Nullable<int> NullableInt(object dbItem)
    { 
       if (Convert.IsDBNull(dbItem)) 
         return null; 
       else
         try {
             return (int)Convert.ToInt32(dbItem);
         } catch {
             return null;
         }       
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or long</param>
    /// <returns>long</returns>
    public static Nullable<long> NullableLong(object dbItem)
    { 
       if (Convert.IsDBNull(dbItem)) 
         return null; 
       else
         try {
             return (long)Convert.ToInt64(dbItem);
         } catch {
             return null;
         }       
    }     /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte array</param>
    /// <returns>byte array</returns>
    public static byte[] NullableBytes(object dbItem)
    { 
       if (Convert.IsDBNull(dbItem)) 
         return null; 
       else
         try {
             return (byte[]) dbItem;
         } catch {
             return null;
         }       
    } 


    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or single</param>
    /// <returns>single</returns>
    public static Nullable<Single> NullableSingle(object dbItem) 
    { 
       if (Convert.IsDBNull(dbItem))
         return null; 
       else
         try { 
           return Convert.ToSingle(dbItem); 
         } catch { 
           return null; 
         } 
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or double</param>
    /// <returns>double</returns>
    public static Nullable<double> NullableDouble(object dbItem)  
    { 
       if (Convert.IsDBNull(dbItem))
         return null; 
       else
         try { 
           return Convert.ToDouble(dbItem); 
         } catch { 
           return null; 
         } 
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or float</param>
    /// <returns>float</returns>
    public static Nullable<float> NullableFloat(object dbItem)
    { 
           if (Convert.IsDBNull(dbItem))
             return null; 
           else
             try { 
               return (float)dbItem; 
             } catch { 
               return null; 
             } 
    } 
    
    /// <summary>
    /// if the database field [dbItem] is null, [0.0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or decimal</param>
    /// <returns>decimal</returns>
    public static Nullable<decimal> NullableDec(object dbItem) 
    { 
       if (Convert.IsDBNull(dbItem))
         return null; 
       else
         try { 
           return Convert.ToDecimal(dbItem); 
         } catch { 
           return null; 
         } 
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date</param>
    /// <returns>System.DateTime</returns>
    public static Nullable<System.DateTime> NullableDate(object dbItem)
    { return NullableDateTime(dbItem); }
    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or date</param>
    /// <returns>System.DateTime</returns>
    public static Nullable<System.DateTime> NullableDateTime(object dbItem) 
    { 
       if (Convert.IsDBNull(dbItem))
         return null; 
       else 
         try { 
           return Convert.ToDateTime(dbItem); 
         } catch { 
           return null; 
         }     
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or timespan</param>
    /// <returns>System.TimeSpan</returns>
    public static Nullable<System.TimeSpan> NullableTime(object dbItem)  
    { 
       if (Convert.IsDBNull(dbItem))
         return null; 
       else 
         try { 
           return TimeSpan.Parse(dbItem.ToString()); 
         } catch { 
           return null; 
         }     
    } 

    /// <summary>
    /// if the database field [dbItem] is null, [MinValue] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or (string)date</param>
    /// <returns>string</returns>
    public static string NullableDateStr(object dbItem) { return NullableDate(dbItem, ""); }
    public static string NullableDate(object dbItem, string format)
    { 
       if (Convert.IsDBNull(dbItem)) 
         return null; 
       else 
         try {
             if (format == "")
                 return Convert.ToDateTime(dbItem).ToString();
             else
                 return Convert.ToDateTime(dbItem).ToString(format); 
         } catch { 
           return null; 
         }     
    }
    /// <summary>
    /// if the database field [dbItem] is null, [0] will be returned
    /// </summary>
    /// <param name="dbItem">the value from the database column.  usually a NULL or byte</param>
    /// <returns>byte</returns>
    public static Nullable<byte> NullableByte(object dbItem)
    {
         if (Convert.IsDBNull(dbItem))
             return null;
         else
             try
             {
                 return (byte)Convert.ToByte(dbItem);
             }
             catch
             {
                 return null;
             }
     }  
    #endregion

}