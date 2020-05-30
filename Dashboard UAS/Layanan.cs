using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;
using LiveCharts;
using LiveCharts.Wpf;

namespace Dashboard_UAS
{
    public partial class Layanan : UserControl
    {
        private string connstring = "Server=localhost; Port=5432; User Id = postgres; Password=root; Database=ekspedisi";
        private NpgsqlConnection conn;
        private NpgsqlCommand cmd;
        private DataTable dt;
        private string sql;

        public string regulerFrekuensi;
        public string expressFrekuensi;
        public string godSpeedFrekuensi;

        public Layanan()
        {
            InitializeComponent();
        }

        private void Layanan_Load(object sender, EventArgs e)
        {

            conn = new NpgsqlConnection(connstring);
            getLayananTable();
            getRegulerFrekuensi();
            getExpressFrekuensi();
            getGodSpeedFrekuensi();
            getLayananDiagram();

            frekuensiGodSpeed.Text = godSpeedFrekuensi;
            frekuensiReguler.Text = regulerFrekuensi;
            frekuensiExpress.Text = expressFrekuensi;

        }

        public void getLayananTable()
        {
            try
            {
                conn.Open();

                sql = "SELECT " +
                            "layanan.nama_layanan," +
                            "COUNT(paket.id_paket) AS total " +
                       "FROM layanan " +
                       "INNER JOIN paket ON layanan.id_layanan = paket.id_layanan " +
                       "GROUP BY layanan.nama_layanan";

                cmd = new NpgsqlCommand(sql, conn);
                dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void getRegulerFrekuensi()
        {
            DataRow[] result = dt.Select("nama_layanan = 'Reguler'");
            foreach (DataRow row in result)
            {
                regulerFrekuensi = row[1].ToString();
            }
        }

        public void getExpressFrekuensi()
        {
            DataRow[] result = dt.Select("nama_layanan = 'Express'");
            foreach (DataRow row in result)
            {
                expressFrekuensi = row[1].ToString();
            }
        }

        public void getGodSpeedFrekuensi()
        {
            DataRow[] result = dt.Select("nama_layanan = 'God Speed'");
            foreach (DataRow row in result)
            {
                godSpeedFrekuensi = row[1].ToString();
            }
        }

        public void getLayananDiagram()
        {
            Func<ChartPoint, string> labelpoint = chartpoint => string.Format("{0} ({1:P})", chartpoint.Y, chartpoint.Participation);
            SeriesCollection series = new SeriesCollection();
            DataRow[] result = dt.Select();
            foreach (DataRow row in result)
            {
                series.Add(new PieSeries() { 
                    Title = row[0].ToString(), 
                    Values = new ChartValues<int> { Int32.Parse(row[1].ToString()) },
                    DataLabels = true,
                    LabelPoint = labelpoint
                });
            }
            pieChart1.Series = series;
            pieChart1.LegendLocation = LegendLocation.Bottom;
        }
    }
}
