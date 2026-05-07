using System;
using System.Web;
using System.Xml.Serialization;
using System.Collections;
using System.IO;

namespace ErrorHandling
{
    public class ErrorLogger
    {
        #region Public Static Functions
        /// <summary>
        /// This static function gets the contents of an exception and writes it to 
        /// the log file. It also writes everything in the Request object to the log 
        /// file.
        /// </summary>
        /// <param name="ex"></param>
        public static void LogException(Exception ex)
        {
            string blank = null;
            LogException(ex, blank);
        }
        public static void LogException(Exception ex, string AdditionalInfo)
        {
            SerializableException sx = new SerializableException(ex);
            string strEx = sx.Serialize();

            //log to the ErrLog file
            if (AdditionalInfo != null) LogMessage(" Error info: [" + AdditionalInfo + "]");
            LogMessage(" Exception:" + strEx);
        }
        public static void LogException(Exception ex, System.Web.HttpRequest Request)
        {
            LogException(ex, Request, null);
        }
        public static void LogException(Exception ex, System.Web.HttpRequest Request, string AdditionalInfo)
        {
            LogException(ex, AdditionalInfo);

            SerializableRequest sr = new SerializableRequest(Request);
            ////this logging feature isn't ready yet, so skip it for now
            //string strReq = sr.Serialize();

            ////log to the ErrLog file
            //if (AdditionalInfo != null) LogMessage(" Error info: [" + AdditionalInfo + "]");
            //LogMessage(" Request:" + strReq);
        }
        public static void LogException(Exception ex, System.Web.SessionState.HttpSessionState HttpSession)
        {
            LogException(ex, HttpSession, null);
        }
        public static void LogException(Exception ex, System.Web.SessionState.HttpSessionState HttpSession, string AdditionalInfo)
        {
            LogException(ex, AdditionalInfo);

            SerializableSession ss = new SerializableSession(HttpSession);
            string strSes = ss.Serialize();

            //log to the ErrLog file
            if (AdditionalInfo != null) LogMessage(" Error info: [" + AdditionalInfo + "]");
            LogMessage(" Session:" + strSes);
        }

        public static void LogMessage(string msg)
        {
            //log to the web root, ErrLog folder with a file name matching todays date
            string strFilePath = LogFile();
            string strDateTime = DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();

            System.IO.File.AppendAllText(strFilePath, strDateTime + msg + Environment.NewLine);
        }

        /// <summary>
        /// Use this function to save a file that is stored in a session var or that was uploaded, etc.
        /// </summary>
        /// <param name="fileBytes">file data contents</param>
        /// <param name="fileName">the file name (without the path)</param>
        public static void SaveFile(byte[] fileBytes, string fileName)
        {
            using (BinaryWriter binWriter = new BinaryWriter(File.Open(settings.ErrLogPath() + "\\" + fileName, FileMode.Create)))
            {
                binWriter.Write(fileBytes);
            }         
        }
        #endregion

        #region Private Helper functions
        private static string LogFile()
        { 
            return settings.ErrLogPath() + "\\" + DateTime.Today.ToString("yyyyMMdd") + ".log";
        }
        #endregion

        #region Supporting Private Inner-classes
        [Serializable]
        public class SerializableException : SerializableBase
        {
            public string Message = "";
            public string StackTrace = "";
            public string Source = "";
            public SerializableException InnerException = null;

            public SerializableException()
            { }
            public SerializableException(Exception ex)
            { 
                this.Message = ex.Message;
                this.StackTrace = ex.StackTrace;
                this.Source = ex.Source;
                if (ex.InnerException != null) this.InnerException = new SerializableException(ex.InnerException);
            }

            //public string Serialize()
            //{
            //    return ;
            //}
        }

        [Serializable]
        public class SerializableRequest : SerializableBase
        {
            //ToDo: use the DictionarySerializer to serialize the HashTables
            public Hashtable Cookies = new Hashtable();
            public Hashtable Form = new Hashtable();
            public Hashtable QueryString = new Hashtable();

            public SerializableRequest()
            { }
            public SerializableRequest(HttpRequest Request)
            {
                //copy the cookies over
                foreach (String key in Request.Cookies.Keys)
                {
                    this.Cookies.Add(key, Request.Cookies[key]);
                }
                //copy the form variables
                foreach (String key in Request.Form.Keys)
                {
                    this.Form.Add(key, Request.Form[key]);
                }
                //copy the querystring variables
                foreach (String key in Request.QueryString.Keys)
                {
                    this.QueryString.Add(key, Request.QueryString[key]);                
                }
            }

            //ToDo: use the DictionarySerializer to serialize the HashTables
            //public string Serialize()
            //{
            //    return this.Serialize();
            //}
        }

        [Serializable]
        public class SerializableSession : SerializableBase
        {
            public Hashtable Session = new Hashtable();

            public SerializableSession()
            { }
            public SerializableSession(System.Web.SessionState.HttpSessionState HttpSession)
            {
                //copy the Session vars over
                foreach (String key in HttpSession.Keys)
                {
                    this.Session.Add(key, Session[key]);
                }
            }

            //public string Serialize()
            //{
            //    return this.Serialize();
            //}
        }
        [Serializable]
        public class SerializableBase
        {
            #region Serialization
            //turns this object into a string [xml]
            public String Serialize()//Type type)
            {
                String strOut = "";
                //the serializer will conver the XML into an object
                XmlSerializer ser = new XmlSerializer(this.GetType());

                //we need a string writer to catch the outgoing stream
                System.IO.StringWriter sw = new System.IO.StringWriter();

                //now we turn the object into a chunk of XML (that gets 
                //stuffed into a stream writer)
                ser.Serialize(sw, this);

                //get the text from the StreamWriter
                strOut = sw.ToString();
                sw.Close();
                sw.Dispose();

                return strOut;
            }

            public static SerializableBase Deserialize(String xml, Type type)
            {
                SerializableBase obj = new SerializableBase();

                //------------------
                //now parse the xml
                //------------------

                //the serializer will conver the XML into an object
                XmlSerializer ser = new XmlSerializer(type);

                //the serializer needs to read the string from a stream
                //so I create a string reader to convert the string into a stream
                System.IO.StringReader sr = new System.IO.StringReader(xml);

                //this actually changes the xml into the object
                obj = (SerializableBase)ser.Deserialize(sr);
                sr.Close();
                sr.Dispose();

                return obj;
            }
            #endregion
        }

        #region Dictionary Serializer
        class DictionarySerializer : IXmlSerializable
        {
            private IDictionary dictionary;
         
            public DictionarySerializer()
            {
                this.dictionary = new Hashtable();
            }
         
            private DictionarySerializer(IDictionary dictionary)
            {
                this.dictionary = dictionary;
            }
         
            public static void Serialize(IDictionary dictionary, Stream stream)
            {
                DictionarySerializer ds = new DictionarySerializer(dictionary);
                XmlSerializer xs = new XmlSerializer(typeof(DictionarySerializer));
                xs.Serialize(stream, ds);
            }
         
            public static IDictionary Deserialize(Stream stream)
            {
                XmlSerializer xs = new XmlSerializer(typeof(DictionarySerializer));
                DictionarySerializer ds = (DictionarySerializer)xs.Deserialize(stream);
                return ds.dictionary;
            }
         
            System.Xml.Schema.XmlSchema IXmlSerializable.GetSchema()
            {
                return null;
            }
         
            void IXmlSerializable.ReadXml(System.Xml.XmlReader reader)
            {
                reader.Read();
                reader.ReadStartElement("dictionary");
                while (reader.NodeType != System.Xml.XmlNodeType.EndElement)
                {
                    reader.ReadStartElement("item");
                    string key = reader.ReadElementString("key");
                    string value = reader.ReadElementString("value");
                    reader.ReadEndElement();
                    reader.MoveToContent();
                    dictionary.Add(key, value);
                }
                reader.ReadEndElement();
            }
         
            void IXmlSerializable.WriteXml(System.Xml.XmlWriter writer)
            {
                writer.WriteStartElement("dictionary");
                foreach (object key in dictionary.Keys)
                {
                    object value = dictionary[key];
                    writer.WriteStartElement("item");
                    writer.WriteElementString("key", key.ToString());
                    writer.WriteElementString("value", value.ToString());
                    writer.WriteEndElement();
                }
                writer.WriteEndElement();
            }
        } 
        #endregion
        #endregion
    }
}
