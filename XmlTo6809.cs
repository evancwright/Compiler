using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.IO;
using System.Windows.Forms;

namespace XMLto6809
{
    class XmlTo6809 : XmlConverter
    {

        static XmlTo6809 instance = null;
         
        // string testRoutine = "if (GUARD HUT.holder==5) { print(\"You have the lamp\"); if (WHITE CUBE.description!=1) { print (\"It's open.\"); FLASHLIGHT.holder=offscreen;} }";

        private XmlTo6809()
        {
           
        }

        public static XmlTo6809 GetInstance()
        {
            if (instance == null)
            {
                instance = new XmlTo6809();
            }

            return instance;
        }
        //ObjectTable objTable = new ObjectTable();

        public void Convert6809(string fileName)
        {
            

            //get the file path 
            CreateTables(fileName);

            WriteWelcomMessage();
            WriteStringTable6809("DescriptionTable6809.asm", "description_table", descriptionTable);
            WriteStringTable6809("Dictionary6809.asm", "dictionary", dict);
            WriteStringTable6809("NogoTable6809.asm", "nogo_table", nogoTable);
            WriteStringTable6809("PrepTable6809.asm", "prep_table", prepTable);
            WriteObjectTable6809("ObjectTable6809.asm");
            WriteObjectWordTable("ObjectWordTable6809.asm", ".db");
            WriteVerbTable("VerbTable6809.asm");
            WriteCheckTable("CheckRules6809.asm");
            WriteSentenceTable("before");
            WriteSentenceTable("instead");
            WriteSentenceTable("after");
            WriteEvents(doc);
            WriteUserVarTable(doc);
            WriteBackdropTable(doc);
        }


        public void ConvertZ80(string fileName)
        {


            //get the file path 
            CreateTables(fileName);

           // WriteWelcomMessage();
            WriteStringTableZ80("StringTableZ80.asm", "string_table", descriptionTable);
            WriteStringTableZ80("DictionaryZ80.asm", "dictionary", dict);
            WriteStringTableZ80("NogoTableZ80.asm", "nogo_table", nogoTable);
            WriteStringTableZ80("PrepTableZ80.asm", "prep_table", prepTable);
          //  WriteObjectTable6809("ObjectTable6809.asm");
            WriteObjectWordTable("ObjectWordTableZ80.asm", "DB");
            WriteVerbTableZ80("VerbTableZ80.asm");
           /*  WriteCheckTable("CheckRules6809.asm");
               WriteSentenceTable("before");
               WriteSentenceTable("instead");
               WriteSentenceTable("after");
               WriteEvents(doc);
               WriteUserVarTable(doc);
               WriteBackdropTable(doc); */
        }

      
        

        private void WriteStringTable6809(string fileName, string header, Table t)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + fileName);
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine(header);
                for (int i = 0; i < t.GetNumEntries(); i++)
                {
                    if (t.GetEntry(i).Length > 0) //safety check
                    {
                        sw.WriteLine("\t.db " + t.GetEntry(i).Length);
                        sw.WriteLine("\t.strz \"" + t.GetEntry(i) + "\" ; " + i);
                    }
                }
                sw.WriteLine("\t.db 0");

            }

        }
        private void WriteStringTableZ80(string fileName, string header, Table t)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + fileName);
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine(header);
                for (int i = 0; i < t.GetNumEntries(); i++)
                {
                    if (t.GetEntry(i).Length > 0) //safety check
                    {
                        sw.WriteLine("\tDB " + t.GetEntry(i).Length);
                        sw.WriteLine("\tDB \"" + t.GetEntry(i) + "\" ; " + i);
                        sw.WriteLine("\tDB 0 ; null terminator");
                    }
                }
                sw.WriteLine("\tDB 0");

            }

        }

        private void WriteObjectTable6809(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; OBJECT_TABLE");
                sw.WriteLine("; FORMAT: ID,HOLDER,INITIAL DESC,DESC,N,S,E,W,NE,SE,SW,NW,UP,DOWN,OUT,MASS");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("obj_table");

                foreach (GameObject o in objects)
                {
                    //write the data bytes
                    sw.Write("\t.db ");
                    sw.Write(o.id.ToString() + ",");
                    sw.Write(o.holder.ToString() + ",");

                    int initialDescVal = 255;
                    string initialDesc = o.initialdescription;
                    if (initialDesc != "")
                    {
                        initialDescVal = descriptionTable.GetEntryId(o.initialdescription);
                    }
                    sw.Write(initialDescVal + ",");

                    if (o.description != "")
                    {
                        sw.Write(descriptionTable.GetEntryId(o.description));
                    }
                    else
                    {
                        sw.Write("0"); //no description
                    }

                    for (int i = 0; i < GameObject.NUM_ATTRIBS; i++)
                    {
                        //if attrib is a direction and there is a nogo message, get the id
                        if (o.HasNogoMsg(GameObject.attribNames[i])) // directions
                        {
                            int msgId = nogoTable.GetEntryId(o.GetNogoMsg(GameObject.attribNames[i]));
                            int uId = 256 - msgId;
                            sw.Write("," + uId.ToString());
                        }
                        else
                        {
                            sw.Write("," + o.attribs[i].ToString());
                        }
                    }
                    sw.Write("   ; " + o.name);

                    //write the two bytes with the flags
                    sw.WriteLine("");

                    List<string> flags = new List<string>();

                    //first 8 flags
                    for (int i = 0; i < 8; i++)
                    {
                        bool val = o.GetXmlFlag(GameObject.xmlFlagNames[i]);
                        if (val)
                        {
                            flags.Add(asmFlagNames[i]);
                        }
                    }

                    string flagsStr = "";
                    if (flags.Count == 0) { sw.WriteLine("\t.db 0    ;  flags 1 - 8"); }
                    else
                    {
                        for (int i = 0; i < flags.Count; i++)
                        {
                            if (i != 0) { flagsStr += "|"; }
                            flagsStr += flags[i];
                        }
                        sw.WriteLine("\t.db " + flagsStr + " ; flags 1-8");
                    }


                    //second 8 flags
                    flags.Clear();

                    for (int i = 8; i < GameObject.xmlFlagNames.Length; i++)
                    {
                        bool val = o.GetXmlFlag(GameObject.xmlFlagNames[i]);
                        if (val)
                        {
                            flags.Add(asmFlagNames[i]);
                        }
                    }

                    flagsStr = "";
                    if (flags.Count == 0) { sw.WriteLine("\t.db 0    ;  flags 9 - 16"); }
                    else
                    {
                        for (int i = 0; i < flags.Count; i++)
                        {
                            if (flagsStr.Length > 0) { flagsStr += "|"; }
                            flagsStr += flags[i];
                        }
                        sw.WriteLine("\t.db " + flagsStr + " ; flags 9-16");
                    }


                }//end each obj

                sw.WriteLine("\t.db 255");

            }
        }


        private void WriteObjectWordTable(string fileName, string byteDirective=".DB")
        {


            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; OBJECT WORD TABLE");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("obj_word_table");

                char[] delimiterChars = { ' ' };

                foreach (GameObject o in objects)
                {
                    sw.Write("\t" + byteDirective + " " + o.id);

                    string name = o.name;

                    string[] toks = name.Split(delimiterChars);
                    int count = toks.Length;

                    int blanks = 3 - count;

                    for (int i = 0; i < count; i++)
                    {
                        //look up the id of each word
                        int wordId = dict.GetEntryId(toks[i]);
                        sw.Write("," + wordId);
                    }

                    //now append the blanks
                    for (int i = 0; i < blanks; i++)
                    {
                        sw.Write(",255");
                    }

                    sw.WriteLine("   ;   " + o.name);
                }//end write objs


                //now write any synonyms
                foreach (GameObject o in objects)
                {
                    if (o.synonyms.Count > 0)
                    {
                        sw.Write("\t" + byteDirective + " " + o.id);
                        int blanks = 3 - o.synonyms.Count;

                        for (int i = 0; i < o.synonyms.Count; i++)
                        {
                            //look up the id of each word
                            int wordId = dict.GetEntryId(o.synonyms[i]);
                            sw.Write("," + wordId);
                        }

                        //now append the blanks
                        for (int i = 0; i < blanks; i++)
                        {
                            sw.Write(",255");
                        }

                        sw.WriteLine("   ;   synonyms for " + o.name);
                    }//end write synonyms
                }

                sw.WriteLine("\t" + byteDirective + " 255");
                sw.WriteLine("obj_table_size\t" + byteDirective + " " + objects.Count);
            }
        }

       

        private void WriteVerbTable(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; VerbTable6809.asm ");
                sw.WriteLine("; Machine Generated Verb Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                char[] seps = { ',' };


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);
                    string[] toks = verb.Split(seps);
                    string verb_id = toks[0].ToLower().Replace(' ', '_') + "_verb_id";
                    sw.WriteLine(verb_id + " equ " + i);
                }

                sw.WriteLine("");
                sw.WriteLine("");

                sw.WriteLine("verb_table");


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);

                    //split it up using commas
                    string[] toks = verb.Split(seps);

                    for (int j = 0; j < toks.Length; j++)
                    {
                        sw.WriteLine("\t.db " + i);
                        sw.WriteLine("\t.db " + toks[j].Length);
                        sw.WriteLine("\t.strz \"" + toks[j].ToUpper() + "\"");
                    }
                }

                sw.WriteLine("\t.db 0,0");
            }
        }


        private void WriteVerbTableZ80(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; VerbTableZ80.asm ");
                sw.WriteLine("; Machine Generated Verb Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                char[] seps = { ',' };


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);
                    string[] toks = verb.Split(seps);
                    string verb_id = toks[0].ToLower().Replace(' ', '_') + "_verb_id";
                    sw.WriteLine(verb_id + " equ " + i);
                }

                sw.WriteLine("");
                sw.WriteLine("");

                sw.WriteLine("verb_table");


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);

                    //split it up using commas
                    string[] toks = verb.Split(seps);

                    for (int j = 0; j < toks.Length; j++)
                    {
                        sw.WriteLine("\tDB " + i);
                        sw.WriteLine("\tDB " + toks[j].Length);
                        sw.WriteLine("\tDB \"" + toks[j].ToUpper() + "\"");
                        sw.WriteLine("\tDB 0 ; null");
                    }
                }

                sw.WriteLine("\tDB 255");
            }
        }

        /*Write each event to a separate file,
         * then write out one file that includes all of them
         */
        private void WriteEvents(XmlDocument doc)
        {
            List<String> eventFiles = new List<string>();
            XmlNodeList events = doc.SelectNodes("//project/events/event");

            foreach (XmlNode n in events)
            {
                //
                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');

                eventFiles.Add(fileName + "_event");

                AsmWriter6809 asm = new AsmWriter6809();
                using (StreamWriter sw = File.CreateText(fileName + "_event_6809.asm"))
                {
                    asm.WriteRoutine(name + "_event", n.InnerText, sw);
                }
            }

            XmlNodeList subs = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in subs)
            {

                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');

                eventFiles.Add(fileName + "_sub");
                AsmWriter6809 asm = new AsmWriter6809();
                using (StreamWriter sw = File.CreateText(fileName + "_sub_6809.asm"))
                {
                    asm.WriteRoutine(name + "_sub", n.InnerText, sw);
                }
            }


            //now write out the main include file
            using (StreamWriter sw = File.CreateText("events6809.asm"))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; Machine generated include file");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                foreach (string s in eventFiles)
                {
                    sw.WriteLine("\tinclude " + s + "_6809.asm");
                }
            }


            //now write out the jumps to the event routines
            using (StreamWriter sw = File.CreateText("event_jumps_6809.asm"))
            {
                sw.WriteLine("; jump to machine generated subroutines");

                foreach (string s in eventFiles)
                {
                    if (s.IndexOf("event") != -1)
                    {
                        sw.WriteLine("\tjsr " + s);
                    }
                }

            }

        }
 

        public int GetStringId(string text)
        {
            return descriptionTable.GetEntryId(text);
        }

        public bool IsSubroutine(string name)
        {
            if (name.IndexOf("(") == -1)
            {
                return false;
            }

            string trimmed = name.Substring(0, name.IndexOf("("));
            return routineNames.Contains(trimmed + "_sub");
        }


        public int GetObjectId(string name)
        {
            try
            {
                name = name.Trim().ToUpper();

                //if it's a numeric constant, use that
                int val = -1;
                if (Int32.TryParse(name, out val))
                {
                    return val;
                }

                if (name == "") { return 255; }
                if (name == "*") { return 254; }

                foreach (GameObject o in objects)
                {
                    if (o.name.ToUpper().Equals(name))
                    {
                        return o.id;
                    }
                }
                throw new Exception("unkown object: " + name);

            }
            catch (Exception e)
            {
                throw new Exception("Unknown object: " + name);
            }
        }

        /*
        private void WriteNogoTable(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; NO GO TABLE");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("nogo_table");

                for (int i=0; i < nogoTable.GetNumEntries(); i++)
                {
                    sw.WriteLine("\t.db " + nogoTable.GetEntry(i).Length);
                    sw.WriteLine("\t.strz \"" + nogoTable.GetEntry(i) + "\"");
                }
                sw.WriteLine("\t.db 255");
            }
        }
        */
        /*
        private void GameObjectTo6809(GameObject gobj, StreamWriter sw)
        {

        }*/

        /*type should be "before" "instead" or "after"
         */
        private void WriteSentenceTable(string type)
        {
            XmlNodeList subs = doc.SelectNodes("//project/sentences/sentence");

            using (StreamWriter sw = File.CreateText(type + "_table_6809.asm"))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; SentenceTable6809.asm ");
                sw.WriteLine("; Machine Generated Sentence Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                if (type.Equals("before"))
                    sw.WriteLine("preactions_table");
                else if (type.Equals("instead"))
                    sw.WriteLine("actions_table");
                else if (type.Equals("after"))
                    sw.WriteLine("postactions_table");
                else
                    throw new Exception("Invalid sentence type.");

                foreach (XmlNode s in subs)
                {

                    if (s.Attributes.GetNamedItem("type").Value == type)
                    {
                        string verb = s.Attributes.GetNamedItem("verb").Value;
                        int verbId = GetVerbId(verb);

                        string prep = s.Attributes.GetNamedItem("prep").Value;
                        int prepId = prepTable.GetEntryId(prep);
                        if (prepId == -1)
                        {
                            prepId = 255;
                            // throw new Exception("Unknown prep \"" + prep + "\" in sentence that starts with: " + verb );
                        }

                        string doObj = s.Attributes.GetNamedItem("do").Value;
                        int doId = GetObjectId(doObj);

                        string ioObj = s.Attributes.GetNamedItem("io").Value;
                        int ioId = GetObjectId(ioObj);

                        sw.WriteLine("\t.db " + verbId + "," + doId + "," + prepId + "," + ioId + "\t;" + verb + " " + doObj + " " + prep + " " + ioObj);

                        string subName = s.Attributes.GetNamedItem("sub").Value;
                        sw.WriteLine("\t.dw " + subName + "_sub");
                    }
                }

                sw.WriteLine("\t.db 255");
                sw.WriteLine("");

            }
        }




        //writes out the check rules
        private void WriteCheckTable(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; check rules table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                XmlNodeList checks = doc.SelectNodes("//project/checks/check");
                sw.WriteLine("");
                sw.WriteLine("check_table");

                foreach (XmlNode c in checks)
                {
                    string verb = c.Attributes.GetNamedItem("verb").Value;
                    int verbId = GetVerbId(verb);
                    string subName = c.Attributes.GetNamedItem("check").Value;
                    sw.WriteLine("\t.db " + verbId + " ; " + verb);
                    sw.WriteLine("\t.dw " + subName);
                }

                sw.WriteLine("\t.db 255");
            }
        }

        void WriteWelcomMessage()
        {
            using (StreamWriter sw = File.CreateText("Welcome6809.asm"))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; welcome message include file");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                XmlNodeList list = doc.SelectNodes("//project/welcome");
                sw.WriteLine("");
                sw.WriteLine("welcome .strz  \"" + list[0].InnerText + "\"");
                list = doc.SelectNodes("//project/author");
                sw.WriteLine("author .strz  \"" + list[0].InnerText + "\"");
                list = doc.SelectNodes("//project/version");
                sw.WriteLine("version .strz  \"" + list[0].InnerText + "\"");
            }
        }

        int GetVerbId(string v)
        {
            char[] seps = { ',' };

            for (int i = 0; i < verbs.GetNumEntries(); i++)
            {
                string s = verbs.GetEntry(i);
                string[] toks = s.Split(seps);

                foreach (string t in toks)
                {
                    if (t.ToUpper().Equals(v.ToUpper()))
                    {
                        return i;
                    }
                }
            }

            return -1;
        }

        public bool IsVar(string s)
        {
            return varTable.Keys.Contains(s);
        }

        int GetObjId(string oname)
        {

            for (int i = 0; i < objects.Count; i++)
            {
                if (objects[i].name.ToUpper().Equals(oname.ToUpper()))
                {
                    return i;
                }
            }

            return -1;
        }


       

        void WriteUserVarTable(XmlDocument doc)
        {
            using (StreamWriter sw = File.CreateText("UserVars6809.asm"))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; User variables");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                foreach (UserVar v in userVars)
                {
                    sw.WriteLine(v.name + "\t.db " + v.initialVal);
                }

            }
             
        }

        private void WriteBackdropTable(XmlDocument doc)
        {
            using (StreamWriter sw = File.CreateText("BackDropTable6809.asm"))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; Machine Generated Backdrop Table ");
                sw.WriteLine("; Format: id, followed by 5 rooms where that object is visible (or 255)");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("backdrop_table");
                for (int i=0; i < objects.Count; i++)
                {
                    GameObject o = objects[i];

                    if (o.IsBackdrop())
                    {
                        sw.Write("\t.db " + o.id );

                        for (int j=0; j < o.backdropRooms.Length; j++)
                        {
                            sw.Write("," + o.backdropRooms[j]);
                        }
                        sw.WriteLine(" ; " + o.name);
                    }
                }
                sw.WriteLine("\t.db 255");
            }
        }

        public string GetVarAddr(string varName)
        {
            if (varTable.Keys.Contains(varName))
            {
                return varTable[varName];
            }
            else
            {
                throw new Exception("Unknown varibale: " + varName);
            }
        }

    }//end class
}
