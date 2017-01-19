using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace XMLto6809
{
    class AsmWriter6809
    {
        //int labelId=65;
        int labelId = 97;
        const int IF_STATEMENT = 0;
        const int IF_ELSE_STATEMENT = 1;
        const int ELSE_STATEMENT = 3;
        const int CODE = 4;

        Dictionary<string, Int32> attrIndexes = new Dictionary<string, int>();
        Dictionary<string, string> propBytes = new Dictionary<string, string>();  //which byte to look in
        Dictionary<string, string> propBits = new Dictionary<string, string>(); //bit masks
        
        List<string> labelStack = new List<string>();
 
        public AsmWriter6809()
        {
            attrIndexes.Add("id", 0);
            attrIndexes.Add("holder", 1);
            attrIndexes.Add("initial_description", 2);
            attrIndexes.Add("description", 3);
            attrIndexes.Add("n", 4);
            attrIndexes.Add("s", 5);
            attrIndexes.Add("e", 6);
            attrIndexes.Add("w", 7);
            attrIndexes.Add("ne", 8);
            attrIndexes.Add("se", 9);
            attrIndexes.Add("sw", 10);
            attrIndexes.Add("nw", 11);
            attrIndexes.Add("up", 12);
            attrIndexes.Add("down", 13);
            attrIndexes.Add("in", 14);
            attrIndexes.Add("out", 15);
            attrIndexes.Add("mass", 16);

            /* BYTE1
             * SCENERY_MASK equ 1
            SUPPORTER_MASK equ 2
            CONTAINER_MASK equ 4
            TRANSPARENT_MASK equ 8
            OPENABLE_MASK equ 16
            OPEN_MASK equ 32
            LOCKABLE_MASK equ 64
            LOCKED_MASK equ 128
             */

            propBytes.Add("scenery", "PROPERTY_BYTE_1");
            propBytes.Add("supporter", "PROPERTY_BYTE_1");
            propBytes.Add("container", "PROPERTY_BYTE_1");
            propBytes.Add("transparent", "PROPERTY_BYTE_1");
            propBytes.Add("openable", "PROPERTY_BYTE_1");
            propBytes.Add("open", "PROPERTY_BYTE_1");
            propBytes.Add("lockable", "PROPERTY_BYTE_1");
            propBytes.Add("locked", "PROPERTY_BYTE_1");



            /*
            PORTABLE_MASK equ 1
            EDIBLE_MASK equ 2
            DRINKABLE_MASK equ 4
            FLAMMABLE_MASK equ 8
            LIGHTABLE_MASK equ 16
            LIT_MASK equ 32	
            EMITTING_LIGHT_MASK equ 32
            DOOR_MASK equ 64
            UNUSED_MASK equ 128
            */
            propBytes.Add("portable", "PROPERTY_BYTE_2");
            propBytes.Add("edible", "PROPERTY_BYTE_2");
            propBytes.Add("flammable", "PROPERTY_BYTE_2");
            propBytes.Add("lightable", "PROPERTY_BYTE_2");
            propBytes.Add("lit", "PROPERTY_BYTE_2");
            propBytes.Add("door", "PROPERTY_BYTE_2");

            //bit masks

            /*
            SCENERY_MASK equ 1
            SUPPORTER_MASK equ 2
            CONTAINER_MASK equ 4
            TRANSPARENT_MASK equ 8
            OPENABLE_MASK equ 16
            OPEN_MASK equ 32
            LOCKABLE_MASK equ 64
            LOCKED_MASK equ 128
             */

            propBits.Add("scenery", "1");
            propBits.Add("supporter", "2");
            propBits.Add("container", "4");
            propBits.Add("transparent", "8");
            propBits.Add("openable", "16");
            propBits.Add("open", "32");
            propBits.Add("lockable", "64");
            propBits.Add("locked", "128");
            /*
             PORTABLE_MASK equ 1
            EDIBLE_MASK equ 2
            DRINKABLE_MASK equ 4
            FLAMMABLE_MASK equ 8
            LIGHTABLE_MASK equ 16
            LIT_MASK equ 32	
            EMITTING_LIGHT_MASK equ 32
            DOOR_MASK equ 64
            UNUSED_MASK equ 128
             */
            propBits.Add("portable", "1");
            propBits.Add("edible", "2");
            propBits.Add("drinkable", "4");
            propBits.Add("flammable", "8");
            propBits.Add("lightable", "16");
            propBits.Add("lit", "32");
            propBits.Add("door", "64");
            propBits.Add("unused", "128");

        }

        public void WriteRoutine(string name, string code, StreamWriter sw)
        {
            labelId = 65;
            sw.WriteLine(""); 
            sw.WriteLine("; machine generate routine from XML file");
            sw.WriteLine(name);
            sw.WriteLine("\tpshs d,x,y");
            code = code.Replace("\r\n","");
            WriteCode(code, sw);
            sw.WriteLine("\tpuls y,x,d");
            sw.WriteLine("\trts");
            sw.WriteLine("");
        }

         

        public void WriteExpr(string code, string label, StreamWriter sw)
        {
            //extract the ()
            try
            {
                string op = GetOperator(code);

                string right = code.Substring(code.IndexOf(op));
                string left = code.Substring(1, code.IndexOf(".") - 1);
                //    string attr = code.Substring(code.IndexOf("."), code.IndexOf(op) - code.IndexOf(op));
                right = right.Substring(2, right.IndexOf(")") - 2);
                string val = right;
                int valId = XmlTo6809.GetInstance().GetObjectId(val);

                left = left.Trim();
                int objId = -1;
                if (left != "$dobj" && left != "iobj")
                {
                   objId = XmlTo6809.GetInstance().GetObjectId(left.Trim()); ;
                } 

                //is there a .? if not, the 
                string attrName = code.Substring(code.IndexOf(".") + 1, code.IndexOf(op) - code.IndexOf(".") - 1);

                attrName = attrName.Trim().ToLower();
                int value;
                if (attrIndexes.TryGetValue(attrName, out value))
                {//test attr
                    int attrNum = value;
                    WriteAttrTest(code, objId, left.Trim(), attrName, attrNum, op, valId, label, sw);
                }
                else if (IsProperty(attrName))
                {//test property

                    WritePropTest(code, objId, left.Trim(), attrName, op, valId, label, sw);
                }
                else if (IsVar(code))
                {//var test
                    int x = 5;
                }
            }
            catch (Exception e)
            {
                throw new Exception(e.Message + "\r\nError near: " + code);
            }
        }


        private void WriteAttrTest(string code, int objId, string objName, string attrName, int attrNum, string op, int val, string label, StreamWriter sw)
        {
            sw.WriteLine("\tnop ; test (" + code + ")");
            sw.WriteLine("\tlda #" + val);
            sw.WriteLine("\tpshs a    ; push right side");

            if (objName.Equals("$dobj"))
                sw.WriteLine("\tlda sentence+1 ; direct obj");
            else if (objName.Equals("$iobj"))
                sw.WriteLine("\tlda sentence+3 ; indirect obj");
            else       
                sw.WriteLine("\tlda #" + objId + " ; " + objName);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + attrNum + ",x  ; " + attrName);
            sw.WriteLine("\tlda ,x");
            sw.WriteLine("\tcmpa ,s ; compare to right side");
            sw.WriteLine("\tpshu cc ; save flags");
            sw.WriteLine("\tleas 1,s ; pop right side");
            sw.WriteLine("\tpulu cc ; restore flags");
            sw.WriteLine("\t" + GetOpCode(op) + " @" + label);

        }


        private void WritePropTest(string code, int objId, string objName, string propName, string op, int val, string label, StreamWriter sw)
        {

            sw.WriteLine("\tnop ; test (" + code + ")");
            sw.WriteLine("\tlda #" + val);
            sw.WriteLine("\tpshs a    ; push right side");
            if (objName.Equals("$dobj"))
                 sw.WriteLine("\tlda sentence+1 ; direct obj");
            else if (objName.Equals("$iobj"))
                 sw.WriteLine("\tlda sentence+3 ; indirect obj");
            else
                sw.WriteLine("\tlda #" + objId);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            string propByte = propBytes[propName];
            sw.WriteLine("\tleax " + propByte + ",x  ; ");
            sw.WriteLine("\tlda ,x  ; get property byte");
            sw.WriteLine("\tanda #" + propBits[propName]  +  " ; isolate " + propName + "  bit ");
            //need property byte
            int bit = Convert.ToInt32(propBits[propName]);
            int pos = (int)Math.Log(bit,2);

            //right justify value so it is a 1 or 0
            for (int i = 0; i < pos; i++ )
            {
                sw.WriteLine("\tasra ; right justify bit" );
            }
            sw.WriteLine("\tcmpa ,s ; compare to right side");
            sw.WriteLine("\tpshu cc ; save flags");
            sw.WriteLine("\tleas 1,s ; pop right side");
            sw.WriteLine("\tpulu cc ; restore flags");
            sw.WriteLine("\t" + GetOpCode(op) + " @" + label);
        }

        public void WriteCode(string code, StreamWriter sw)
        {
            //does it start with an 'if' statement
            code = code.Trim();
            if (code.Length > 0 && code != "}")
            {
//                int type = GetBlockType(code);

                if (code.IndexOf("if")==0 )
                {
                    string label = getNextLabel();
                                     
                    int start = code.IndexOf("(");
                    int end = code.IndexOf(")");
                    string expr = code.Substring(start, (end - start)+1);

                    WriteExpr(expr, label, sw);

                    //find the matching }
                    string remainder = code.Substring(code.IndexOf("{"));

                    int closingBrace = findClosingBrace(remainder);
                    string inside = remainder.Substring(1, closingBrace-1).Trim();
                    string outside = remainder.Substring(closingBrace+1).Trim();  //the next block or statements

                    WriteCode(inside, sw);

                    //while outside is an else if  or else
                    
                    //will we need a branch
                    if (PeekAheadForElse(outside))
                    {
                        string l = getNextLabel();
                        labelStack.Add(l);
                        sw.WriteLine("\tbra @" + l + " ; skip else ");
                    }
                    //close block
                    sw.WriteLine("@" + label + "\tnop ; close " + expr);

                    WriteCode(outside, sw);
                }
                else if (code.IndexOf("else")==0)
                {
                 
                    code = code.Substring(4); //strip off 'else'
                    WriteCode(code, sw);

                    string l = labelStack[labelStack.Count - 1];
                    labelStack.RemoveAt(labelStack.Count - 1);

                    sw.WriteLine("@" + l + "\tnop ; end else");

                }
                else
                {//must just be statements

                    //first part must be a set attr
                    //chop it off, then parse the rest
                    string statement = code.Substring(0, code.IndexOf(";"));
                    
                    sw.WriteLine("\tnop ; " + statement);

                    //what kind of statement is it?
                    //if there's a += or -=
                    //if there's a '=' and a '.' then it's an object attr or prop assignment
                    //if there's a '=' and no '.' then its a variable assignment
                    //if there's a "print", then it's a print statement
                    
                    if (statement.IndexOf("printl") != -1)
                    {
                        WritePrintStatement(statement, sw);
                        WritePrintNewline(sw);
                    }
                    else if (statement.IndexOf("print") != -1)
                    {
                        WritePrintStatement(statement, sw);
                    }
                    else if (statement.IndexOf("look()") != -1)
                    {
                        WriteLookStatement(sw);
                    }
                    else if (statement.IndexOf("move()") != -1)
                    {
                        WriteMoveStatement(sw);
                    }
                    else if (XmlTo6809.GetInstance().IsSubroutine(statement))
                    {
                        string subName = statement.Substring(0, statement.IndexOf("("));
                        WriteSubroutineCall(subName, sw);
                    }
                    else if (statement.IndexOf(".") != -1) 
                    { //attribute or property assignment
                        string right = statement.Substring(statement.IndexOf("=") + 1, statement.Length - statement.IndexOf("=") - 1).Trim();
                        string attr = statement.Substring(statement.IndexOf(".")+1, statement.IndexOf("=")-statement.IndexOf(".")-1).Trim();
                        string obj = statement.Substring(0,statement.IndexOf("."));
                        int objId = XmlTo6809.GetInstance().GetObjectId(obj);
                        int valId = -1; 

                        if (IsAttribute(attr))
                        {//attribute
                            //get the right side of the epression
                            //is this a string assignment?
                            int result;
                            if (right.IndexOf("\"") == 0)
                            {
                                string rest = right.Substring(1);
                                string inside = rest.Substring(0, rest.IndexOf("\""));
                                valId =  XmlTo6809.GetInstance().GetStringId(inside);
                            }
                            else if (Int32.TryParse(right,out result))
                            {//not an int.  It's an obj.  look up it's ID
                                valId = result;
                            }
                            else
                            {
                                valId = XmlTo6809.GetInstance().GetObjectId(right);
                            }

                            int attrNum = attrIndexes[attr.Trim().ToLower()];

                            //convert right to an id;
                            WriteAttrAssignment(objId,obj, attrNum, attr, valId, sw);
                        }
                        else  
                        {//property assignment
                            int bit = ToBit(right);
                            WritePropAssignment(objId, obj, attr, bit, sw);
                        }


                    }//end attr or prop assignment (dot found)
                     

                    string remainder = code.Substring(code.IndexOf(";")+1);
                    WriteCode(remainder, sw);
                }
            }
        }

        //the starting { has NOT been chopped off
        private int findClosingBrace(string code)
        {
            int count = 0;
            for (int i = 0; i < code.Length; i++)
            {
                if (code[i] == '{') count++;

                if (code[i] == '}')
                {
                    count--;
                    if (count == 0) { return i; }

                }

            }
                return -1;
        }

        private string getNextLabel()
        {
            char c = Convert.ToChar(labelId++);
            return c.ToString().ToLower();
        }

        public void WriteAttrAssignment(int objId, string obj, int attrNum, string attr, int valId, StreamWriter sw)
        {
            if (obj.Equals("$dobj"))
                sw.WriteLine("\tlda sentence+1 ; " + obj);
            else if (obj.Equals("$iobj"))
                sw.WriteLine("\tlda sentence+3 ; " + obj);
            else
                sw.WriteLine("\tlda #" + objId + " ; " + obj);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + attrNum + ",x   ;" + attr);
            sw.WriteLine("\tlda #" + valId);
            sw.WriteLine("\tsta ,x");
        }

        public void WritePropAssignment(int objId, string obj, string propName, int val, StreamWriter sw)
        {
            string propByte = propBytes[propName];
            sw.WriteLine("\tnop ; set " + obj + "." + propName + "=" + val);
            sw.WriteLine("\tlda #" + objId + " ; " + obj);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + propByte + ",x");
            sw.WriteLine("\tlda ,x  ; get property byte");
            // clear the bit
            sw.WriteLine("\tldb #" + propBits[propName] + " ; get the mask for " + propName);
            sw.WriteLine("\tcomb " + propBits[propName] + " ; invert it");
            sw.WriteLine("\tpshs b");
            sw.WriteLine("\tanda ,s   ; clear the bit");
            sw.WriteLine("\tleas 1,s ; pop stack");
            if (val == 1)
            {
                sw.WriteLine("\tora #" + propBits[propName] +  "   ; set the " + propName + " bit");
            }
            sw.WriteLine("\tsta ,x  ; store it");
        }

        private string GetOpCode(string op)
        {
            if (op == "==")
            {
                return "lbne";
            }
            else if (op == "!=")
            {
                return "lbeq";
            }
            else 
            {
                throw new Exception("bad relational operator:" + op);
            }
        }

        private void WritePrintStatement(string statement, StreamWriter sw)
        {
            int start = statement.IndexOf("\"");
            string rem = statement.Substring(start + 1);
            int end = rem.IndexOf("\"");
            string text = rem.Substring(0, end);


            sw.WriteLine("\tldx #description_table");
            sw.WriteLine("\tlda #" + XmlTo6809.GetInstance().GetStringId(text) + " ; " + text);
            sw.WriteLine("\tpshu a");
            sw.WriteLine("\tjsr print_table_entry");
        }

        private void WritePrintNewline(StreamWriter sw)
        {
            sw.WriteLine("\tjsr PRINTCR");
        }

        private string GetOperator(string code)
        {
            string[] ops = { "==", "!=", "<", ">" };

            for (int i = 0; i < ops.Length; i++)
            {
                if (code.IndexOf(ops[i])!=-1)
                {
                    return ops[i];
                }
            }

            throw new Exception("Invalid relational operator: " + code);
        }

        private bool PeekAheadForElse(string code)
        {
            return (code.IndexOf("else") == 0);
        }

        private int EvalPrint(string expr)
        {
            expr = expr.Trim();

            if (expr[0] == '\"')
            {
                string rest=expr.Substring(1);
                string inside = rest.Substring(0, rest.IndexOf("\""));
                return XmlTo6809.GetInstance().GetStringId(inside);
            }
            else 
            {
                return XmlTo6809.GetInstance().GetObjectId(expr);
            }
        }

        private int GetBlockType(string code)
        {

            if (code.IndexOf("if") == 0)
            {
                //scan ahead for an else

                string right = code.Substring(code.IndexOf("{"));
                int close = findClosingBrace(code);
                string rem = code.Substring(close+1).Trim();

                if (rem.IndexOf("else") == 0)
                {
                    return IF_ELSE_STATEMENT;
                }
                else
                {
                    return IF_STATEMENT;
                }
            }
            else if (code.IndexOf("else")==0)
            {
                return ELSE_STATEMENT;
            }
            else
            {
                return CODE;
            }
        }
        private int ToBit(string val)
        {
            val = val.Trim();
            if (val == "0" || val.ToUpper().Equals("FALSE")) { return 0;}
            return 1;
        }

        private bool IsVar(string name)
        {
            if (name.Equals("dobj)") || name.Equals("iobj") || name.Equals("prep"))
            {
                return true;
            }
            else 
            {
                return false;
            }
        }

        private string GetVarAddr(string varName)
        {
            return XmlTo6809.GetInstance().GetVarAddr(varName);
        }

        private void WriteLookStatement(StreamWriter sw)
        {
            sw.WriteLine("\tjsr look_sub");
        }

        private void WriteMoveStatement(StreamWriter sw)
        {
            sw.WriteLine("\tjsr move_player");
        }

        private void WriteSubroutineCall(string name, StreamWriter sw)
        {
            sw.WriteLine("\tjsr " + name + "_sub");
        }

        /*could be "SOME STRING"
         * could be object name
         * could be integer constant
         * could be $dobj or $obj
         */
        private string ToRegisterLoadOperand(string tok)
        {
            int result;
            if (tok.Equals("$dobj"))
            {
                return "sentence+1";
            }
            else if (tok.Equals("$iobj"))
            {
                return "sentence+3";
            }
            else if (tok.IndexOf("\"") == 0)
            {
                string left = tok.Substring(1);
                string str = left.Substring(0, left.IndexOf("\"") - 1);
                return XmlTo6809.GetInstance().GetStringId(str).ToString();
            }
            else if (XmlTo6809.GetInstance().GetObjectId(tok) != -1)
            {
                return XmlTo6809.GetInstance().GetObjectId(tok).ToString();
            }
            else if (Int32.TryParse(tok, out result))
            {
                return result.ToString();
            }
            else throw new Exception("Unable to evaluate: " + tok);

        }

        private bool IsAttribute(string attr)
        {
            return attrIndexes.Keys.Contains(attr);
        }
        private bool IsProperty(string attr)
        {
            return propBits.Keys.Contains(attr);
        }

     }
}
