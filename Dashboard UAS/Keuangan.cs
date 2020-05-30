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

namespace Dashboard_UAS
{
    public partial class Keuangan : UserControl
    {
        private string connstring = "Server=localhost; Port=5432; User Id = postgres; Password=root; Database=ekspedisi";
        private NpgsqlConnection conn;
        private NpgsqlCommand cmd;
        private DataTable dt;
        private string sql;

        public Keuangan()
        {
            InitializeComponent();
        }

        private void Keuangan_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
            getPemasukanTable();
            getPemasukanDiagram();
            pemasukanLabel.Text = getTotalPemasukan();
        }

        public void getPemasukanTable()
        {
            try
            {
                conn.Open();
                sql = "SELECT " +
                        "to_char(to_timestamp(DATE_PART('month', tanggal_pengiriman)::text, 'MM'), 'Month') AS bulan," +
                        "SUM(ongkir) AS pemasukan " +
                   "FROM paket " +
                   "GROUP BY to_char(to_timestamp(DATE_PART('month', tanggal_pengiriman)::text, 'MM'), 'Month')";

                cmd = new NpgsqlCommand(sql, conn);
                dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                tabelPemasukan.DataSource = null;
                tabelPemasukan.DataSource = dt;
                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void getPemasukanDiagram()
        {
            chart1.Series.Clear();
            chart1.Series.Add("Pemasukan");
            try
            {
                conn.Open();
                sql = "SELECT " + 
                        "to_char(to_timestamp(DATE_PART('month', tanggal_pengiriman)::text, 'MM'), 'Month') AS bulan," +
                        "SUM(ongkir) AS pemasukan " +
                   "FROM paket " +
                   "GROUP BY " +
                        "to_char(to_timestamp(DATE_PART('month', tanggal_pengiriman)::text, 'MM'), 'Month')," +
                        "DATE_PART('month', tanggal_pengiriman) " +
                   "ORDER BY DATE_PART('month', tanggal_pengiriman)";

                cmd = new NpgsqlCommand(sql, conn);
                NpgsqlDataReader myReader = cmd.ExecuteReader();
                while (myReader.Read())
                {
                    chart1.Series["Pemasukan"].Points.AddXY(myReader["bulan"].ToString(), Int32.Parse(myReader["pemasukan"].ToString()));
                }
                conn.Close();
            }
            catch (NpgsqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public string getTotalPemasukan()
        {
            string totalPemasukan = "0";

            try
            {
                conn.Open();

                sql = "SELECT SUM(ongkir) FROM paket";
                cmd = new NpgsqlCommand(sql, conn);
                NpgsqlDataReader myReader = cmd.ExecuteReader();
                myReader.Read();

                if (myReader.HasRows)
                {
                    totalPemasukan = myReader[0].ToString();
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

            return totalPemasukan;
        }
    }
}
