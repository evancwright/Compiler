using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.IO;


namespace XMLto6809
{
    class Prefs
    {

        static Prefs instance = null;

        public XmlPrefs.Prefs xprefs;

        private Prefs() { }

        public static Prefs GetInstance()
        {
            if (instance == null)
            {
                instance = new Prefs();

                //try to load the prefs from the file
                if (File.Exists("prefs.xml"))
                {
                    System.Xml.Serialization.XmlSerializer reader = new XmlSerializer(typeof(XmlPrefs.Prefs));

                    // Read the XML file.
                    StreamReader file = new StreamReader("prefs.xml");

                    // Deserialize the content of the file into a Book object.
                    instance.xprefs = (XmlPrefs.Prefs)reader.Deserialize(file);
                    
                }
            }
            return instance;
        }


        public string LWToolsPath {
            get
            {
                return xprefs.Lwtoolspath;
            }
        }
    }

}

namespace XmlPrefs
{
      [XmlRoot(ElementName = "prefs")]
    public class Prefs
    {
        [XmlElement(ElementName = "lwtoolspath")]
        public string Lwtoolspath { get; set; }
        [XmlElement(ElementName = "tasmpath")]
        public string Tasmpath { get; set; }
        [XmlElement(ElementName = "cygwinpath")]
        public string Cygwinpath { get; set; }

    }

}
