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

        XmlTo6809 project = null;
        public AsmWriter6809()
        {
            project = XmlTo6809.GetInstance();

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
            propBytes.Add("backdrop", "PROPERTY_BYTE_2");
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
            code = code.Replace("\r","");
            code = code.Replace("\n", "");
            code = code.Replace("\t", "");
            WriteCode(code, sw);
            sw.WriteLine("\tpuls y,x,d");
            sw.WriteLine("\trts");
            sw.WriteLine("");
        }

        //this function write the code to put a variables
        //attr into register a
        public void WritePutAttrInA(string expr, StreamWriter sw)
        {
            int dot = expr.IndexOf(".");
            string objName = expr.Substring(0, dot);
            string attrName = expr.Substring(dot + 1, expr.Length - (dot + 1));
            int attrNum = attrIndexes[attrName.Trim().ToLower()];
            sw.WriteLine("nop ; setting up rhs attribute");
            sw.WriteLine("\tlda " + ToRegisterLoadOperand(objName) + " ; " + objName);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + attrNum + ",x  ; " + attrName);
            sw.WriteLine("\tlda ,x");
        }
         

        public void WriteExpr(string code, string label, StreamWriter sw)
        {
            //extract the ()
            try
            {
                string op = GetOperator(code);

                string right = code.Substring(code.IndexOf(op)).Trim();
                string left = code.Substring(1, code.IndexOf(op)-1).Trim();
                 

                //is there a "."  on the left
                if (left.IndexOf(".") != -1)
                {
                    left = code.Substring(1, code.IndexOf(".") - 1);

                    //    string attr = code.Substring(code.IndexOf("."), code.IndexOf(op) - code.IndexOf(op));
                    right = right.Substring(2, right.IndexOf(")") - 2);
                    string val = right;
                    int valId = XmlTo6809.GetInstance().GetObjectId(val);

                    left = left.Trim();

                    string attrName = code.Substring(code.IndexOf(".") + 1, code.IndexOf(op) - code.IndexOf(".") - 1);

                    attrName = attrName.Trim().ToLower();
                    int value;
                    if (attrIndexes.TryGetValue(attrName, out value))
                    {//test attr
                        int attrNum = value;
    //                    WriteAttrTest(code, objId, left.Trim(), attrName, attrNum, op, valId, label, sw);
                        WriteAttrTest(code, left.Trim(), attrName, attrNum, op, right, label, sw);
                    }
                    else if (IsProperty(attrName))
                    {//test property
                        WritePropTest(code, left.Trim(), attrName, op, valId, label, sw);
                    }
                }
                else if (IsVar(left))
                {//not dot, it's a var test
                    right = right.Substring(op.Length).Trim();
                    right = right.Substring(0, right.Length - 1);
                    WriteVarTest(code, left, op, right, label, sw);
                }
                else
                {
                    throw new  Exception("unknown variable: " + left);
                }
            }
            catch (Exception e)
            {
                throw new Exception(e.Message + "\r\nError near: " + code);
            }
        }


        private void WriteAttrTest(string code, string objName, string attrName, int attrNum, string op, string val, string label, StreamWriter sw)
        {
            sw.WriteLine("\tnop ; test (" + code + ")");
            sw.WriteLine("\tlda " + ToRegisterLoadOperand(val) + " ;" + val);
            sw.WriteLine("\tpshs a    ; push right side");

            sw.WriteLine("\tlda " + ToRegisterLoadOperand(objName) + " ; " + objName);
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


        private void WritePropTest(string code, string objName, string propName, string op, int val, string label, StreamWriter sw)
        {

            sw.WriteLine("\tnop ; test (" + code + ")");
            sw.WriteLine("\tlda #" + val);
            sw.WriteLine("\tpshs a    ; push right side");
            sw.WriteLine("\tlda " + ToRegisterLoadOperand(objName));
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
//                sw.WriteLine("\tasra ; right justify bit" );
                  sw.WriteLine("\tlsra ; right justify bit");
            }
            sw.WriteLine("\tcmpa ,s ; compare to right side");
            sw.WriteLine("\tpshu cc ; save flags");
            sw.WriteLine("\tleas 1,s ; pop right side");
            sw.WriteLine("\tpulu cc ; restore flags");
            sw.WriteLine("\t" + GetOpCode(op) + " @" + label);
        }

        private void WriteVarTest(string code, string varName, string op, string val, string label, StreamWriter sw)
        {
            sw.WriteLine("\tnop ; test (" + code + ")");
            sw.WriteLine("\tlda " + ToRegisterLoadOperand(varName) + " ; " + varName);
            sw.WriteLine("\tpshs a    ; push right left");
            sw.WriteLine("\tlda " + ToRegisterLoadOperand(val) + " ; " + val);
             
            sw.WriteLine("\tcmpa ,s ; compare to right side");
            sw.WriteLine("\tpshu cc ; save flags");
            sw.WriteLine("\tleas 1,s ; pop right side");
            sw.WriteLine("\tpulu cc ; restore flags");
            sw.WriteLine("\t" + GetOpCode(op) + " @" + label);
        }

        public void WriteCode(string code, StreamWriter sw)
        {

            code = code.Trim();
            if (code.Length > 0 && code != "}")
            {

                //does it start with an 'if' statement

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
                    code = UnWrapCurlyBraces(code);
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
                    else if (statement.IndexOf("add(") != -1)
                    {
                        WriteAddVar(statement, sw);
                    }
                    else if (statement.IndexOf("set(") != -1)
                    {
                        WriteSetVar(statement, sw);
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
                        int objId = -1;
                        try
                        {
                            objId = XmlTo6809.GetInstance().GetObjectId(obj);
                        } catch  {
                            if (!IsVar(obj))
                            {
                                throw new Exception("unknown object: " + obj);
                            }
                        }
                        int valId = -1; 

                        if (IsAttribute(attr))
                        {//attribute
                            
                            int attrNum = attrIndexes[attr.Trim().ToLower()];

                            //convert right to an id;
                            WriteAttrAssignment(objId,obj, attrNum, attr, right, sw);
                        }
                        else  
                        {//property assignment
                            int bit = ToBit(right);
                            WritePropAssignment(objId, obj, attr, bit, sw);
                        }


                    }//end attr or prop assignment (dot found)
                     

                    string remainder = code.Substring(code.IndexOf(";")+1).Trim();
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
        /*
        //write an attribute assignment statement 
        public void WriteAttrAssignment(int objId, string obj, int attrNum, string attr, int valId, StreamWriter sw)
        {
            //top code should put value in a
            
            if (obj.Equals("$dobj"))
                sw.WriteLine("\tlda sentence+1 ; " + obj);
            else if (obj.Equals("$iobj"))
                sw.WriteLine("\tlda sentence+3 ; " + obj);
            else
                sw.WriteLine("\tlda #" + objId + " ; " + obj);
         

            //...then compute the address to store it in.
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + attrNum + ",x   ;" + attr);
            //...then store it
            sw.WriteLine("\tlda #" + valId);  
            sw.WriteLine("\tsta ,x");
        }
*/
        //example objProp = player.holder
        //example objProp = $dobj
        public void WriteAttrAssignment(int objId, string obj, int attrNum, string attr, string rhs, StreamWriter sw)
        {
            //top code should put value in a
            int val;
            if (Int32.TryParse(rhs,out val))
            {//int literal
                sw.WriteLine("\tlda #" + val + " ; " + rhs);
            }
            else if (project.IsVar(rhs))
            {
                sw.WriteLine("\tlda " + project.GetVarAddr(rhs) + " ; " + obj);
            }
            else if (rhs.IndexOf("\"") == 0)
            {//a string
                string rest = rhs.Substring(1);
                string inside = rest.Substring(0, rest.IndexOf("\""));
                int strId = project.GetStringId(inside);
                sw.WriteLine("\tlda #" + strId + " ; " + rhs);
            }
            else if (rhs.IndexOf(".") != -1)
            {//an attribute?
                WritePutAttrInA(rhs, sw);
            }
            else if (rhs[0].Equals("\""))
            {//get string id
                sw.WriteLine("\tlda " + project.GetVarAddr(rhs) + " ; " + rhs);
            } 
            else
            {//and object
                sw.WriteLine("\tlda #" + project.GetObjectId(rhs) + " ; " + rhs);
            }

            sw.WriteLine("\tpshs a ; save value to put in attr");
            //...then compute the address to store it in.
            sw.WriteLine("\tlda #" + objId + " ; " + obj);
            sw.WriteLine("\tldb #OBJ_ENTRY_SIZE");
            sw.WriteLine("\tmul");
            sw.WriteLine("\ttfr d,x");
            sw.WriteLine("\tleax obj_table,x");
            sw.WriteLine("\tleax " + attrNum + ",x   ;" + attr);
            //...then store it
            sw.WriteLine("\tpuls a ; restore rhs");
            sw.WriteLine("\tsta ,x");
        }

        public void WritePropAssignment(int objId, string obj, string propName, int val, StreamWriter sw)
        {
            if (!propBytes.ContainsKey(propName))
            {
                throw new Exception("Invalid property:" + propName);
            }
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
                return XmlTo6809.GetInstance().IsVar(name);
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
            if (Int32.TryParse(tok, out result))
            {
                return "#" + result.ToString();
            } 
            else if (XmlTo6809.GetInstance().IsVar(tok))
            {
                return XmlTo6809.GetInstance().GetVarAddr(tok);
            }
            else if (tok.IndexOf("\"") == 0)
            {
                string left = tok.Substring(1);
                string str = left.Substring(0, left.IndexOf("\"") - 1);
                return "#" + XmlTo6809.GetInstance().GetStringId(str).ToString();
            }
            else if (XmlTo6809.GetInstance().GetObjectId(tok) != -1)
            {
                return "#"+XmlTo6809.GetInstance().GetObjectId(tok).ToString();
            }
            else if (tok.ToUpper().Equals("DOBJ") || tok.ToUpper().Equals("IOBJ"))
            {
                string addr =  GetVarAddr(tok);
                throw new Exception("Not implemted yet!  need to be able to load dobj or iobj : " + tok);
            }
            else throw new Exception("Unable to evaluate: " + tok);

        }

        private void WriteSetVar(string code, StreamWriter sw)
        {
            string trimmed = code.Substring(code.IndexOf("(")+1);
            trimmed = trimmed.Substring(0, trimmed.Length - 1);
            int commaIx = trimmed.IndexOf(',') ;
            string varName = trimmed.Substring(0,commaIx).Trim();
            string val = trimmed.Substring(commaIx+1, trimmed.Length - commaIx-1 );
            
            //write the code to set the var
            sw.WriteLine("\tpshs a");
            sw.WriteLine("\tlda #" + val + " ; load new val");
            sw.WriteLine("\tsta " +  varName +  " ; store it back");
            sw.WriteLine("\tpuls a");
        }

        private void WriteAddVar(string code, StreamWriter sw)
        {
            string trimmed = code.Substring(code.IndexOf("(")+1);
            trimmed = trimmed.Substring(0, trimmed.IndexOf(")") );
            int commaIx = trimmed.IndexOf(',');
            string varName = trimmed.Substring(0,commaIx).Trim();
            string val = trimmed.Substring(commaIx+1).Trim();

            //write the code to set the var
            sw.WriteLine("\tpshs a");
            sw.WriteLine("\tlda " + varName);
            sw.WriteLine("\tpshu a ; push var value");
            sw.WriteLine("\tlda #" + val + " ; push val to add");
            sw.WriteLine("\tadda ,u ; add it ");
            sw.WriteLine("\tsta " + varName + " ; store it back");
            sw.WriteLine("\tpulu a ; remove temp");
            sw.WriteLine("\tpuls a");
        }
        /*
        private void WriteSetVar(string code, StreamWriter sw)
        {
            string trimmed = code.Substring(code.IndexOf("(") + 1);
            trimmed = trimmed.Substring(0, trimmed.IndexOf(")"));
            int commaIx = trimmed.IndexOf(',');
            string varName = trimmed.Substring(0, commaIx).Trim();
            string val = trimmed.Substring(commaIx + 1);

            //write the code to set the var
            sw.WriteLine("\tpshs a");
            sw.WriteLine("\tlda " + varName);
            sw.WriteLine("\tpshu a ; push var value");
            sw.WriteLine("\tlda #" + val + " ; load val to set var to");
            sw.WriteLine("\tsta " + varName + " ; store it");
            sw.WriteLine("\tpuls a");
        }
         */ 

        string UnWrapCurlyBraces(string code)
        {
            if (code[0] == '{')
            {
                int end = code.LastIndexOf("}");
                int start = code.IndexOf("{");
                string unwrapped = code.Substring(start+1, end - start-1);
                return unwrapped;
            }
            else return code;
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
