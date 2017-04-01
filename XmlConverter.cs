using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace XMLto6809
{
    abstract class XmlConverter
    {
        protected XmlDocument doc;
        protected Table nameTable = new Table();
        protected Table nogoTable = new Table();
        protected Table descriptionTable = new Table();
        protected Table dict = new Table();
        protected Table verbs = new Table(); //unsplit strings
        protected Table prepTable = new Table();
        protected List<String> routineNames = new List<String>();
        protected Dictionary<string, string> varTable = new Dictionary<string, string>(); //variables
        protected List<UserVar> userVars = new List<UserVar>();

        //Table strings = new Table(); //for events

        protected List<GameObject> objects = new List<GameObject>();

        protected XmlConverter()
        {
            prepTable.Add(preps);
        }


        protected static string[] asmFlagNames =   { "SCENERY_MASK", "SUPPORTER_MASK", "CONTAINER_MASK", "TRANSPARENT_MASK",
                               "OPENABLE_MASK","OPEN_MASK", "LOCKABLE_MASK", "LOCKED_MASK", 
                               "PORTABLE_MASK", "BACKDROP_MASK", "DRINKABLE_MASK", "FLAMMABLE_MASK", 
                               "LIGHTABLE_MASK", "EMITTING_LIGHT_MASK","DOOR_MASK", "UNUSED_MASK" 
                           };

        protected string[] preps = new string[]
        {            	
	        "IN",
	        "AT",
        	"TO",
        	"INSIDE",
        	"OUT",
        	"UNDER",
        	"ON",
            "OFF",
            "INTO",
            "UP",
            "WITH"
        };


        protected struct UserVar
        {
            public string name;
            public string initialVal;

            public UserVar(string name, string value)
            {
                this.name = name;
                this.initialVal = value;
            }

        }

        protected void CreateTables(string fileName)
        {
            doc = new XmlDocument();
            doc.Load(fileName);
            descriptionTable.Clear();
            descriptionTable.AddEntry("YOU NOTICE NOTHING UNEXPECTED.");
            PopulateNameTable(doc);
            PopulateNogoTable(doc);
            PopulateVerbTable(doc);
            PopulateVariableTable(doc);
            PopulateSubroutineNames(doc);
            ParseForStrings(doc);

        }

        private void PopulateNameTable(XmlDocument doc)
        {
            XmlNodeList list = doc.SelectNodes("//project/objects/object");
            nameTable.Clear();
            objects.Clear();
            descriptionTable.Clear();

            foreach (XmlNode n in list)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                nameTable.AddEntry(name);

                //get the child node with the description
                XmlNode child = n.ChildNodes[0];
                string desc = child.InnerText;

                //don't add blank descriptions
                if (desc != "")
                {
                    descriptionTable.AddEntry(desc);
                }


                //initial desc
                string initialDesc = n.SelectSingleNode("initialdescription").InnerText;

                if (initialDesc != "" && initialDesc != null)
                {
                    descriptionTable.AddEntry(initialDesc);
                }

                //break the name into words and put each word in the dictionary
                char[] delimiterChars = { ' ' };
                string[] toks = name.Split(delimiterChars);

                foreach (string s in toks)
                {
                    if (s != null && !s.Equals(""))
                    {
                        dict.AddEntry(s);
                    }
                }

                //create the object from the data
                GameObject gobj = new GameObject(n);
                objects.Add(gobj);

                foreach (string s in gobj.synonyms)
                {
                    if (!s.Equals(""))
                        dict.AddEntry(s);
                }

            }

        }

        private void PopulateNogoTable(XmlDocument doc)
        {
            XmlNode list = doc.SelectSingleNode("//project/objects");
            nogoTable.Clear();
            nogoTable.AddEntry("BLANK");
            nogoTable.AddEntry("YOU CAN'T GO THAT WAY.");

            foreach (XmlNode child in list)
            {
                XmlNode msgs = child.SelectSingleNode("nogo");

                if (msgs != null)
                {
                    foreach (XmlNode n in msgs.ChildNodes)
                    {
                        if (!n.InnerText.Equals(""))
                        {
                            string msg = n.InnerText;
                            nogoTable.AddEntry(msg);
                        }
                    }
                }

            }

        }

        void PopulateVariableTable(XmlDocument doc)
        {
            XmlNodeList vars = doc.SelectNodes("//project/variables/builtin/var");
            varTable.Clear();

            foreach (XmlNode n in vars)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                string addr = n.Attributes.GetNamedItem("addr").Value;
                string val = n.Attributes.GetNamedItem("value").Value;
                varTable[name] = addr;
            }

            userVars.Clear();

            vars = doc.SelectNodes("//project/variables/user/var");

            foreach (XmlNode n in vars)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                string addr = n.Attributes.GetNamedItem("addr").Value;
                string val = n.Attributes.GetNamedItem("value").Value;
                varTable[name] = name;

                userVars.Add(new UserVar(name, val));
            }
        }

        private void PopulateVerbTable(XmlNode doc)
        {
            verbs.Clear();

            XmlNode biv = doc.SelectSingleNode("//project/verbs/builtinverbs");

            XmlNodeList v = biv.SelectNodes("verb");

            foreach (XmlNode n in v)
            {
                verbs.AddEntry(n.InnerText);
            }

            biv = doc.SelectSingleNode("//project/verbs/userverbs");

            v = biv.SelectNodes("verb");

            foreach (XmlNode n in v)
            {
                verbs.AddEntry(n.InnerText);
            }
        }

        virtual public void Convert() { }

        protected void ParseForStrings(string code)
        {
            try
            {
                int start = code.IndexOf("\"");
                if (start != -1)
                {
                    string rem = code.Substring(start + 1);
                    int end = rem.IndexOf("\"");

                    string substr = rem.Substring(0, end);

                    descriptionTable.AddEntry(substr);
                    string rest = rem.Substring(end + 1);
                    ParseForStrings(rest);
                }
            }
            catch
            {
                throw new Exception("Error in code near: " + code);
            }
        }

        /*
         * Scans for strings in the events and puts them in the description table.
         */
        private void ParseForStrings(XmlDocument doc)
        {
            XmlNodeList events = doc.SelectNodes("//project/events/event");

            foreach (XmlNode n in events)
            {
                string code = n.InnerText;
                ParseForStrings(code);
            }

            events = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in events)
            {
                string code = n.InnerText;
                ParseForStrings(code);
            }
        }

        /*
         * Solves dependency problems
         */
        void PopulateSubroutineNames(XmlDocument doc)
        {
            routineNames.Clear();
            XmlNodeList subs = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in subs)
            {

                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');
                routineNames.Add(fileName + "_sub");
            }
        }
    }
}
