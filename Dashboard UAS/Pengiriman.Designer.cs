namespace Dashboard_UAS
{
    partial class Pengiriman
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
            this.cartesianChart1 = new LiveCharts.WinForms.CartesianChart();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.tabelPengiriman = new System.Windows.Forms.DataGridView();
            this.totalPengirimanLabel = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabelPengiriman)).BeginInit();
            this.SuspendLayout();
            // 
            // cartesianChart1
            // 
            this.cartesianChart1.Location = new System.Drawing.Point(3, 3);
            this.cartesianChart1.Name = "cartesianChart1";
            this.cartesianChart1.Size = new System.Drawing.Size(618, 183);
            this.cartesianChart1.TabIndex = 0;
            this.cartesianChart1.Text = "cartesianChart1";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.CadetBlue;
            this.panel1.Controls.Add(this.totalPengirimanLabel);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Location = new System.Drawing.Point(330, 208);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(200, 100);
            this.panel1.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(47, 16);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(117, 16);
            this.label2.TabIndex = 0;
            this.label2.Text = "Total Pengiriman";
            // 
            // tabelPengiriman
            // 
            this.tabelPengiriman.AllowUserToAddRows = false;
            this.tabelPengiriman.AllowUserToDeleteRows = false;
            this.tabelPengiriman.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.tabelPengiriman.Location = new System.Drawing.Point(20, 208);
            this.tabelPengiriman.MultiSelect = false;
            this.tabelPengiriman.Name = "tabelPengiriman";
            this.tabelPengiriman.ReadOnly = true;
            this.tabelPengiriman.Size = new System.Drawing.Size(304, 161);
            this.tabelPengiriman.TabIndex = 3;
            // 
            // totalPengirimanLabel
            // 
            this.totalPengirimanLabel.AutoSize = true;
            this.totalPengirimanLabel.Font = new System.Drawing.Font("Century Gothic", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalPengirimanLabel.Location = new System.Drawing.Point(93, 42);
            this.totalPengirimanLabel.Name = "totalPengirimanLabel";
            this.totalPengirimanLabel.Size = new System.Drawing.Size(15, 16);
            this.totalPengirimanLabel.TabIndex = 1;
            this.totalPengirimanLabel.Text = "0";
            // 
            // Pengiriman
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.Controls.Add(this.tabelPengiriman);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.cartesianChart1);
            this.Name = "Pengiriman";
            this.Size = new System.Drawing.Size(624, 386);
            this.Load += new System.EventHandler(this.Pengiriman_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabelPengiriman)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private LiveCharts.WinForms.CartesianChart cartesianChart1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DataGridView tabelPengiriman;
        private System.Windows.Forms.Label totalPengirimanLabel;
    }
}
