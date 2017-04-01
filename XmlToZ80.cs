using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace XMLto6809
{
    class XmlToZ80 : XmlConverter
    {
        public void Convert(string fileName)
        {
            CreateTables(fileName);
        }
    }
}
