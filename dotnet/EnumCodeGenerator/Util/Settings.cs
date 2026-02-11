using System; 
using System.Configuration; 
//using System.Collections.Generic;

//<summary> 
// This class reads settings from the web.config file 
//</summary> 
public class Settings 
{     
    public static string Server { 
        get { return ConfigurationSettings.AppSettings["Server"]; } 
    }

    public static string SavePath
    {
        get { return ConfigurationSettings.AppSettings["SavePath"]; }
    }

    public static string Namespace
    {
        get { return ConfigurationSettings.AppSettings["Namespace"]; }
    } 


} 

//settings 