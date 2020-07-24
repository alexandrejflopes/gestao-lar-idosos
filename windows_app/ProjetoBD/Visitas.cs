using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjetoBD
{
    public partial class Visitas : Form
    {
        private SqlConnection cn;

        private Ligacao baseDados;
        
        public Visitas()
        {
            baseDados = new Ligacao();
            InitializeComponent();
            setupVisitas();
        }

        private SqlConnection getSGBDConnection()
        {
            return baseDados.getSGBDConnection(cn);
        }

        private bool verifySGBDConnection()
        {
            cn = getSGBDConnection();
            return baseDados.verifySGBDConnection(cn);
        }




        public void setupVisitas()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from GetVisitas() order by data desc";
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();


            while (reader.Read())
            {
                Visita V = new Visita();

                V.No_utente = (int)reader["no_utente"];
                V.Nome_utente = reader["nome_utente"].ToString();
                V.Nome_visitante = reader["nome_visitante"].ToString();
                V.Cc_visitante = reader["cc_visitante"].ToString();
                V.Data = reader["data"].ToString().Split(null)[0];
                V.Hora_entrada = reader["hora_entrada"].ToString();
                V.Hora_saida = reader["hora_saida"].ToString();

                listaVisitas.Rows.Add(V.No_utente, V.Nome_utente, V.Nome_visitante, V.Cc_visitante, V.Data, V.Hora_entrada, V.Hora_saida);

            }
            reader.Close();
            cn.Close();
        }

        public void acrescentarVisita(Visita v)
        {
            listaVisitas.Rows.Insert(0, v.No_utente, v.Nome_utente, v.Nome_visitante, v.Cc_visitante, v.Data, v.Hora_entrada, v.Hora_saida);
        }


        private void Visitas_FormClosing(object sender, FormClosingEventArgs e)

        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();

        }

        private void ButtonAddVisita_Click(object sender, EventArgs e)
        {
            NovaVisita popUp = new NovaVisita(this);
            popUp.ShowDialog();
        }

        private void BotaoSair_Click(object sender, EventArgs e)
        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();
        }
    }
}
