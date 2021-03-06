﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;

namespace XMLto6809
{
    public partial class Form1 : Form
    {

        string workingDirectory=".\\working";
        string skelDirectory=".\\6809Skel";
        string lwtoolsPath;
        string lwasmPath = "/usr/bin/";
        string buildCmd = "lwasm";
        string args = "--6809 main.asm --list=list_file.txt --output=game.bin";
        string projectDirectory = ".\\output";
        string cygwinPath = "";
        string bashPath = "C:\\cygwin64\\bin";
        string trs80workingDirectory = ".\\trs80Skel";

        public Form1()
        {
            InitializeComponent();
            lwtoolsPath = Prefs.GetInstance().LWToolsPath;
            cygwinPath = Prefs.GetInstance().xprefs.Cygwinpath;
        }

        private void button1_Click(object sender, EventArgs e)
        {
        }

        private void configToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ConfigForm cf = new ConfigForm();
            cf.ShowDialog();

        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        //build CoCo version
        private void buildToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!Directory.Exists(workingDirectory))
            {
                Directory.CreateDirectory(workingDirectory);
            }

            XmlToTables converter = XmlToTables.GetInstance();
            //string oldDir = Environment.CurrentDirectory;
            //Environment.CurrentDirectory = workingDirectory;

            OpenFileDialog ofd = new OpenFileDialog();

            ofd.Filter = "*xml files (*.xml)|*.xml";

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                string fileName = ofd.FileName;
                converter.Convert6809(fileName);  //"f3xml.xml"
            }


            MessageBox.Show("Export complete.  Open the directory " + converter.buildDir + " in Cygwin and run: build.sh");

           // Environment.CurrentDirectory = oldDir;
           // RunBuild();

        }

        //copy the shell files to the output working directory
        void RunBuild()
        {
            //does the output directory exist?
            /*
            string oldDirectory = Environment.CurrentDirectory;
            Environment.CurrentDirectory = workingDirectory;

            if (File.Exists("game.bin"))
            {
                File.Delete("game.bin");
            }

            //copy skel files into working dir
//            string cmd = "COPY /Y " + skelDirectory + "\\*.*  " + workingDirectory;
              textBox1.Clear();
              textBox1.Text += "running:  CMD " + "/C COPY /Y " + "..\\" + skelDirectory + "\\*.*  ." + "\r\n";
              Process p = Process.Start("cmd", "/C COPY /Y ..\\" + skelDirectory + "\\*.*  .");
              p.WaitForExit();

              if (!File.Exists("advent.dsk"))
              {
                  MessageBox.Show("No disk image to attach to");
                  Environment.CurrentDirectory = oldDirectory;
                  return;
              }
              
              textBox1.Text += "running:  "  + "bash" + " " + "-c \"lwasm --6809 main.asm --list=game.list --output=game.bin\"\n";
              //p = Process.Start("C:\\cygwin64\\bin\\bash", "-c \"lwasm --6809 main.asm --list=game.list --output=game.bin\"");
              p = Process.Start("C:\\cygwin64\\bin\\bash", "-c \"./build.sh\"");
              p.WaitForExit();
      
              MessageBox.Show("Done.");                  
              
             Environment.CurrentDirectory = oldDirectory;
             */
        }

        private void setupHelpToolStripMenuItem_Click(object sender, EventArgs e)
        {
           // Process.Start("notepad.exe", "setup.txt");
        }

        private void tRS80ToolStripMenuItem_Click(object sender, EventArgs e)
        {
 
            XmlToTables converter = XmlToTables.GetInstance();
            OpenFileDialog ofd = new OpenFileDialog();

            ofd.Filter = "*xml files (*.xml)|*.xml";

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                string fileName = ofd.FileName;
                converter.ConvertZ80(fileName);  //"f3xml.xml"
            }

            MessageBox.Show("Export complete.  Open the directory " + converter.buildDir + " in Cygwin and run: Z80asm main.asm");

        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("By Evan Wright, 2017");
        }

       
    }
}
