using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.IO.Ports;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ToolBar;
using System.Runtime.Remoting.Metadata.W3cXsd2001;

namespace bluetooth_control
{
    public partial class Form1 : Form
    {
        int cnt = 0;
        String Transmit = string.Empty;
        String Receive = string.Empty;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            String[] ports = SerialPort.GetPortNames();
            timer3.Enabled = false;
            timer4.Enabled = false;
            foreach (string port in ports)
            {
                comboBox1.Items.Add(port);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            serialPort1.PortName = comboBox1.Text;
        }


        private void button1_Click(object sender, EventArgs e)
        {
            if (comboBox1.Text == "")
            {
                MessageBox.Show("Select COM Port.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
            else
            {
                try
                {
                    if (serialPort1.IsOpen)
                    {
                        MessageBox.Show("COM Port is connected and ready for use.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        serialPort1.Open();
                        textBox1.BackColor = Color.Lime;
                        textBox1.Text = "Connecting...";
                        comboBox1.Enabled = false;
                        pictureBox1.Enabled = true;
                        pictureBox3.Enabled = true;
                        pictureBox1.Image = bluetooth_control.Properties.Resources.uo;
                        pictureBox3.Image = bluetooth_control.Properties.Resources.down;
                    }

                }
                catch (Exception)
                {
                    MessageBox.Show("COM Port is not found. Please check your COM or cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                if (serialPort1.IsOpen)
                {
                    timer3.Enabled = false;
                    timer4.Enabled = false;
                    textBox1.BackColor = Color.Red;
                    comboBox1.Enabled = true;
                    textBox1.Text = "Disconnected!";
                    serialPort1.Close();
                }
                else
                {
                    MessageBox.Show("COM Port is disconnected.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }

            }
            catch (Exception)
            {
                MessageBox.Show("COM Port is not found. Please check your COM or cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {
            try
            {
                Transmit = "O";
                serialPort1.Write(Transmit);
                pictureBox2.Image = bluetooth_control.Properties.Resources.stop;
                pictureBox2.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("COM Port is not found. Please check your COM or cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            try
            {
                Transmit = "S";
                serialPort1.Write(Transmit);
                pictureBox1.Image = bluetooth_control.Properties.Resources.not;
                pictureBox3.Image = bluetooth_control.Properties.Resources.not;
                pictureBox1.Enabled = false;
                pictureBox3.Enabled = false;
                timer3.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("COM Port is not found. Please check your COM or cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {
            try
            {
                Transmit = "C";
                serialPort1.Write(Transmit);
                pictureBox2.Image = bluetooth_control.Properties.Resources.stop;
                pictureBox2.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("COM Port is not found. Please check your COM or cable.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult answer = MessageBox.Show("Do you want to exit the program?", "Question", MessageBoxButtons.YesNo, MessageBoxIcon.Question);    //hiển thị hộp thoại kiểm tra người dùng có muốn thoát không
            if (answer == DialogResult.Yes)
            {
                if (serialPort1.IsOpen)
                {
                    Transmit = "S";
                    serialPort1.Write(Transmit);
                    Transmit = "z";
                    serialPort1.Write(Transmit);
                    serialPort1.Close();
                }
            }
            else
            {
                e.Cancel = true;
            }
        }

        private void serialPort1_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            Receive = serialPort1.ReadExisting();
            this.Invoke(new EventHandler(DoUpDate));
        }
        private void DoUpDate(object sender, EventArgs e)
        {
            if (Receive == "o")
            {
                pictureBox6.Image = bluetooth_control.Properties.Resources.cuacuondangmo;
            }
            else if (Receive == "c")
            {
                pictureBox6.Image = bluetooth_control.Properties.Resources.cuacuondangdong;
            }
            else if (Receive == "s")
            {
                pictureBox6.Image = bluetooth_control.Properties.Resources.cuacuondung;
                Transmit = "z";
                serialPort1.Write(Transmit);
                pictureBox1.Image = bluetooth_control.Properties.Resources.not;
                pictureBox3.Image = bluetooth_control.Properties.Resources.not;
                pictureBox1.Enabled = false;
                pictureBox3.Enabled = false;
                timer3.Enabled = true;
            }
            else if (Receive == "q")
            {
                pictureBox6.Image = bluetooth_control.Properties.Resources.cuacuondong;
                pictureBox2.Image = bluetooth_control.Properties.Resources.not;
                pictureBox2.Enabled = false;
                Transmit = "d";
                serialPort1.Write(Transmit);
            }
            else if (Receive == "w")
            {
                pictureBox6.Image = bluetooth_control.Properties.Resources.cuacuonmo;
                pictureBox2.Image = bluetooth_control.Properties.Resources.not;
                pictureBox2.Enabled = false;
                Transmit = "z";
                serialPort1.Write(Transmit);
            }
        }


        private void timer3_Tick(object sender, EventArgs e)
        {
            pictureBox1.Enabled = true;
            pictureBox3.Enabled = true;
            pictureBox1.Image = bluetooth_control.Properties.Resources.uo;
            pictureBox3.Image = bluetooth_control.Properties.Resources.down;
            timer3.Enabled = false;
            cnt = 0;
        }

        private void timer4_Tick(object sender, EventArgs e)
        {
            if (serialPort1.IsOpen)
            {
                serialPort1.Close();
            }
            timer4.Enabled = false;
        }
    }
}
