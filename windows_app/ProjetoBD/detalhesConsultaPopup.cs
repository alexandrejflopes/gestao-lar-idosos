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
    public partial class detalhesConsultaPopup : Form
    {
        private Consulta consultaAtual;
        private int noPresc;
        private SqlConnection cn;
        private Ligacao baseDados;

        public detalhesConsultaPopup(Consulta c, int presc)
        {
            baseDados = new Ligacao();

            InitializeComponent();
            consultaAtual = c;
            noPresc = presc;
            Console.WriteLine("Consulta recebida popup: " + c.ToString());
            setupPrescricao();
            setupFarmacos();
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


        public void setupPrescricao()
        {
            titlePrescricao.Text = "Prescrição nº " + noPresc;
            textDataPresc.Text = consultaAtual.Data;
        }


        public void setupFarmacos()
        {
            listaFarmacos.ReadOnly = true;
            if (!verifySGBDConnection())
                return;
            // select * from GetFarmacosConsulta(2017, 14) join REFERE on nome=nome_farmaco where num_prescricao = 10001

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select nome, REFERE.farmaceutica as farm, freq, data_fim_tratamento from GetFarmacosConsulta(@ano, @no_consulta) join REFERE on nome = nome_farmaco where num_prescricao = " + noPresc;
            cmd.Parameters.AddWithValue("@ano", consultaAtual.Ano);
            cmd.Parameters.AddWithValue("@no_consulta", consultaAtual.Numero);
            cmd.Connection = cn;
            SqlDataReader reader = cmd.ExecuteReader();


            while (reader.Read())
            {
                String nomeFarmaco = reader["nome"].ToString();
                String farmaceutica = reader["farm"].ToString();
                String frequencia = reader["freq"].ToString();
                String fimTratamento = reader["data_fim_tratamento"].ToString().Split(null)[0];
               
                listaFarmacos.Rows.Add(nomeFarmaco, farmaceutica, frequencia, fimTratamento);


            }
            reader.Close();
            cn.Close();
            

        }
    }
}
