using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Class.Util
{
    public class ToNullable
    {
        #region Nullable
        /// <summary>
        /// if the text (input) field [strItem] is blank, [null] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or bool</param>
        /// <returns>Nullable of bool</returns>
        public static Nullable<bool> ToNullableBool(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return Convert.ToBoolean(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [null] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or int</param>
        /// <returns>Nullable of int</returns>
        public static Nullable<int> NullableInt(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return (int)Convert.ToInt32(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [null] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or long</param>
        /// <returns>Nullable of long</returns>
        public static Nullable<long> NullableLong(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return (long)Convert.ToInt64(strItem);
                }
                catch
                {
                    return null;
                }
        }     
        
        /// <summary>
        /// if the text (input) field [strItem] is blank, [null] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or byte array</param>
        /// <returns>Nullable of byte array</returns>
        public static byte[] NullableBytes(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return System.Text.ASCIIEncoding.ASCII.GetBytes(strItem);
                }
                catch
                {
                    return null;
                }
        }


        /// <summary>
        /// if the text (input) field [strItem] is blank, [0.0] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or single</param>
        /// <returns>Nullable of single</returns>
        public static Nullable<Single> NullableSingle(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return Convert.ToSingle(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [0.0] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or double</param>
        /// <returns>Nullable of double</returns>
        public static Nullable<double> NullableDouble(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return Convert.ToDouble(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [0.0] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or float</param>
        /// <returns>Nullable of float</returns>
        public static Nullable<float> NullableFloat(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return float.Parse(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [0.0] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or decimal</param>
        /// <returns>Nullable of decimal</returns>
        public static Nullable<decimal> NullableDec(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return Convert.ToDecimal(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [MinValue] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or date</param>
        /// <returns>Nullable of System.DateTime</returns>
        public static Nullable<System.DateTime> NullableDate(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return Convert.ToDateTime(strItem);
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [strItem] is blank, [MinValue] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or timespan</param>
        /// <returns>Nullable of System.TimeSpan</returns>
        public static Nullable<System.TimeSpan> NullableTime(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return (System.TimeSpan)DateTime.Parse(strItem).TimeOfDay;
                }
                catch
                {
                    return null;
                }
        }

        /// <summary>
        /// if the text (input) field [dtItem] is blank, [MinValue] will be returned
        /// </summary>
        /// <param name="dtItem">The value from the TimePicker.  Usually null or timespan</param>
        /// <returns>Nullable of System.TimeSpan</returns>
        public static Nullable<System.TimeSpan> NullableTime(DateTime? dtItem)
        {
            if (!dtItem.HasValue)
            {
                return null;
            }
            else
            {
                try
                {
                    return dtItem.Value.TimeOfDay;
                }
                catch
                {
                    return null;
                }
            }
        }

        /// <summary>
        /// if the text (input) field [tsItem] is blank, [MinValue] will be returned
        /// </summary>
        /// <param name="tsItem">The value from the TimePicker.  Usually null or timespan</param>
        /// <returns>Nullable of System.TimeSpan</returns>
        public static Nullable<System.DateTime> NullableTime(TimeSpan? tsItem)
        {
            if (!tsItem.HasValue)
            {
                return null;
            }
            else
            {
                try
                {
                    return new DateTime(2000,1,1,tsItem.Value.Hours,tsItem.Value.Minutes,tsItem.Value.Seconds);
                }
                catch
                {
                    return null;
                }
            }
        }



        /// <summary>
        /// if the text (input) field [strItem] is blank, [MinValue] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or (string)date</param>
        /// <returns>Nullable of string</returns>
        public static string NullableDateStr(string strItem) { return NullableDate(strItem, ""); }
        public static string NullableDate(object strItem, string format)
        {
            if (strItem.ToString() == "")
                return null;
            else
                try
                {
                    if (format == "")
                        return Convert.ToDateTime(strItem).ToString();
                    else
                        return Convert.ToDateTime(strItem).ToString(format);
                }
                catch
                {
                    return null;
                }
        }
        /// <summary>
        /// if the text (input) field [strItem] is blank, [0] will be returned
        /// </summary>
        /// <param name="strItem">The value from the textbox.  Usually [blank] or byte</param>
        /// <returns>Nullable of byte</returns>
        public static Nullable<byte> NullableByte(string strItem)
        {
            if (strItem == "")
                return null;
            else
                try
                {
                    return (byte)Convert.ToByte(strItem);
                }
                catch
                {
                    return null;
                }
        }
        #endregion


    }
}