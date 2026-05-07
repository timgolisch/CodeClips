using System;
using System.Web;
using System.Xml.Serialization;


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
