namespace Dashboard_UAS
{
    partial class Layanan
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel1 = new System.Windows.Forms.Panel();
            this.frekuensiGodSpeed = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.frekuensiReguler = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel3 = new System.Windows.Forms.Panel();
            this.frekuensiExpress = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.pieChart1 = new LiveCharts.WinForms.PieChart();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel3.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.CadetBlue;
            this.panel1.Controls.Add(this.frekuensiGodSpeed);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Location = new System.Drawing.Point(390, 51);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(200, 89);
            this.panel1.TabIndex = 2;
            // 
            // frekuensiGodSpeed
            // 
            this.frekuensiGodSpeed.AutoSize = true;
            this.frekuensiGodSpeed.Font = new System.Drawing.Font("Century Gothic", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.frekuensiGodSpeed.Location = new System.Drawing.Point(87, 40);
            this.frekuensiGodSpeed.Name = "frekuensiGodSpeed";
            this.frekuensiGodSpeed.Size = new System.Drawing.Size(24, 25);
            this.frekuensiGodSpeed.TabIndex = 1;
            this.frekuensiGodSpeed.Text = "0";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(33, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(142, 16);
            this.label2.TabIndex = 0;
            this.label2.Text = "Layanan God Speed";
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.CadetBlue;
            this.panel2.Controls.Add(this.frekuensiReguler);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Location = new System.Drawing.Point(390, 146);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(200, 89);
            this.panel2.TabIndex = 3;
            // 
            // frekuensiReguler
            // 
            this.frekuensiReguler.AutoSize = true;
            this.frekuensiReguler.Font = new System.Drawing.Font("Century Gothic", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.frekuensiReguler.Location = new System.Drawing.Point(87, 41);
            this.frekuensiReguler.Name = "frekuensiReguler";
            this.frekuensiReguler.Size = new System.Drawing.Size(24, 25);
            this.frekuensiReguler.TabIndex = 2;
            this.frekuensiReguler.Text = "0";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(43, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(119, 16);
            this.label1.TabIndex = 0;
            this.label1.Text = "Layanan Reguler";
            // 
            // panel3
            // 
            this.panel3.BackColor = System.Drawing.Color.CadetBlue;
            this.panel3.Controls.Add(this.frekuensiExpress);
            this.panel3.Controls.Add(this.label3);
            this.panel3.Location = new System.Drawing.Point(390, 241);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(200, 89);
            this.panel3.TabIndex = 4;
            // 
            // frekuensiExpress
            // 
            this.frekuensiExpress.AutoSize = true;
            this.frekuensiExpress.Font = new System.Drawing.Font("Century Gothic", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.frekuensiExpress.Location = new System.Drawing.Point(87, 43);
            this.frekuensiExpress.Name = "frekuensiExpress";
            this.frekuensiExpress.Size = new System.Drawing.Size(24, 25);
            this.frekuensiExpress.TabIndex = 3;
            this.frekuensiExpress.Text = "0";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(43, 11);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(117, 16);
            this.label3.TabIndex = 0;
            this.label3.Text = "Layanan Express";
            // 
            // pieChart1
            // 
            this.pieChart1.Location = new System.Drawing.Point(37, 51);
            this.pieChart1.Name = "pieChart1";
            this.pieChart1.Size = new System.Drawing.Size(347, 279);
            this.pieChart1.TabIndex = 5;
            this.pieChart1.Text = "pieChart1";
            // 
            // Layanan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.Controls.Add(this.pieChart1);
            this.Controls.Add(this.panel3);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Name = "Layanan";
            this.Size = new System.Drawing.Size(624, 386);
            this.Load += new System.EventHandler(this.Layanan_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label frekuensiGodSpeed;
        private System.Windows.Forms.Label frekuensiReguler;
        private System.Windows.Forms.Label frekuensiExpress;
        private LiveCharts.WinForms.PieChart pieChart1;
    }
}
