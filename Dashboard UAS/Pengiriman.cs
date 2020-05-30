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
    public partial class Pengiriman : UserControl
    {
        private string connstring = "Server=localhost; Port=5432; User Id = postgres; Password=root; Database=ekspedisi";
        private NpgsqlConnection conn;
        private NpgsqlCommand cmd;
        private DataTable dt;
        private string sql;

        public Pengiriman()
        {
            InitializeComponent();
        }

        private void Pengiriman_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
            getPengirimanTable();
            getPengirimanDiagram();
            totalPengirimanLabel.Text = getTotalPengiriman();
        }

        public void getPengirimanTable()
        {
            try
            {
                conn.Open();
                sql = "SELECT " +
                        "DATE_PART('year', tanggal_pengiriman) AS tahun," +
                        "DATE_PART('month', tanggal_pengiriman) AS bulan," +
                        "COUNT(*) AS frekuensi " +
                    "FROM paket " +
                    "GROUP BY " +
                        "DATE_PART('month', tanggal_pengiriman)," +
                        "DATE_PART('year', tanggal_pengiriman) " +
                    "ORDER BY DATE_PART('month', tanggal_pengiriman) ASC";

                cmd = new NpgsqlCommand(sql, conn);
                dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                tabelPengiriman.DataSource = null;
                tabelPengiriman.DataSource = dt;
                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void getPengirimanDiagram()
        {
            // CARTESIAN CHART
            // setting up the x axis and y axis
            cartesianChart1.AxisX.Add(new LiveCharts.Wpf.Axis
            {
                Title = tabelPengiriman.Columns[1].Name,
                Labels = new[] { "Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des" }
            });

            cartesianChart1.AxisY.Add(new LiveCharts.Wpf.Axis
            {
                Title = "Frekuensi",
                LabelFormatter = value => value.ToString()
            });
            cartesianChart1.LegendLocation = LiveCharts.LegendLocation.Right;

            // setting up the data that will be visualized through line
            cartesianChart1.Series.Clear();
            SeriesCollection series = new SeriesCollection();

            try
            {
                conn.Open();

                NpgsqlDataReader myReader = cmd.ExecuteReader();

                // select distinct year (year is represented by line)
                List<string> yearsList = new List<string>();
                while (myReader.Read())
                {
                    yearsList.Add(myReader["tahun"].ToString());
                }

                var years = yearsList.Distinct();

                // create dot based on monthly frequency
                foreach (var year in years)
                {
                    List<double> frekuensiList = new List<double>();
                    for (int month = 1; month <= 12; month++)
                    {
                        double frekuensi = 0;
                        DataRow[] result = dt.Select("tahun = " + year + " AND bulan = " + month);
                        foreach (DataRow row in result)
                        {
                            frekuensi = Double.Parse(row[2].ToString());
                        }
                        frekuensiList.Add(frekuensi);
                    }
                    series.Add(new LineSeries()
                    {
                        Title = year.ToString(),
                        Values = new ChartValues<double>(frekuensiList)
                    });
                }
                cartesianChart1.Series = series;
                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public string getTotalPengiriman()
        {
            string totalPengiriman = "0";

            try
            {
                conn.Open();

                sql = "SELECT COUNT(id_paket) FROM paket";
                cmd = new NpgsqlCommand(sql, conn);
                NpgsqlDataReader myReader = cmd.ExecuteReader();
                myReader.Read();

                if (myReader.HasRows)
                {
                    totalPengiriman = myReader[0].ToString();
                }
                else
                {
                    return "0";
                }

                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }

            return totalPengiriman;
        }
    }
}
