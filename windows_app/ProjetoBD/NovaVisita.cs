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
    public partial class NovaVisita : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;


        private Utente utenteSelecionado;
        private int idxUtenteSelecionado;

        private Visitante visianteSelecionado;
        private int idxVisitanteSelecionado;

        private Visitante visitanteCriado;

        private Visitante visitanteInserido;

        private bool comNovoVisitante;
        private Visita visitaInserida;

        Visitas paginaVisitas;

        public NovaVisita(Visitas v)
        {
            baseDados = new Ligacao();
            InitializeComponent();
            visitaInserida = new Visita();
            visitanteCriado = new Visitante();
            visitanteInserido = new Visitante();
            paginaVisitas = v;
            setupUtentes();
            setupVisitantes();
            ClearFields();

            comboBoxVisitantes.Enabled = false;
            hideNovoVisitante();
            showVisitanteExistente();

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


        // -------------------------------------------------- SETUP --------------------------------------------------

        private void setupUtentes()
        {
            if (!verifySGBDConnection())
                return;

            Console.WriteLine("Entrei no setup utentes.");

            SqlCommand cmd = new SqlCommand("SELECT * from GetUtentes() order by no_utente", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxUtentes.Items.Clear();

            while (reader.Read())
            {
                Utente U = new Utente();
                U.No_utente = reader["no_utente"].ToString();
                U.Cc_responsavel = reader["cc_responsavel"].ToString();
                U.Id_alojamento = reader["id_alojamento"].ToString();
                U.Nome = reader["nome"].ToString();
                U.Fotografia = reader["fotografia"].ToString();
                U.Alcunha = reader["alcunha"].ToString();
                U.Data_nasc = reader["data_nasc"].ToString();
                U.Sexo = reader["sexo"].ToString();
                U.Estado_civil = reader["estado_civil"].ToString();
                U.NIF = reader["NIF"].ToString();
                U.Morada_anterior = reader["morada_anterior"].ToString();
                U.Data_entrada = reader["data_entrada"].ToString();
                U.Sns = reader["sns"].ToString();
                U.Niss = reader["niss"].ToString();
                U.Subsistema_saude = reader["subsistema_saude"].ToString();
                U.Grau_dependencia = reader["grau_dependencia"].ToString();
                U.Num_telemovel = reader["num_telemovel"].ToString();

                comboBoxUtentes.Items.Add(U);

                Console.WriteLine("Adicionado U " + U.ToString());

            }

            cn.Close();
        }


        private void setupVisitantes()
        {
            if (!verifySGBDConnection())
                return;

            Console.WriteLine("Entrei no setup visitantes.");

            SqlCommand cmd = new SqlCommand("SELECT * from GetVisitantes() order by nome", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxVisitantes.Items.Clear();

            while (reader.Read())
            {
                Visitante V = new Visitante();
                V.Cartao_cidadao = reader["cartao_cidadao"].ToString();
                V.Nome = reader["nome"].ToString();

                comboBoxVisitantes.Items.Add(V);
                Console.WriteLine("Adicionado V " + V.ToString());

            }


            cn.Close();
        }





        // -------------------------------------------------- BOTOES --------------------------------------------------
        private void ComboBoxUtentes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxUtentes.SelectedIndex >= 0)
            {
                
                idxUtenteSelecionado = comboBoxUtentes.SelectedIndex;
                utenteSelecionado = (Utente)comboBoxUtentes.Items[idxUtenteSelecionado];
                Console.WriteLine("Utente atual visita popup: " + utenteSelecionado.ToString());
            }
        }

        private void ConfirmarButton_Click(object sender, EventArgs e)
        {

            if (comNovoVisitante)
            {
                AddNovoVisitante();
            }

            addVisita();


            paginaVisitas.acrescentarVisita(visitaInserida);
            Console.WriteLine("Visita criada (depois do ADD): " + visitaInserida.ToString());

            //paginaVisitas.setupVisitas();

            this.Dispose();
            
        }


        private void AddNovoVisitante()
        {
            if (!verifySGBDConnection())
                return;

            setVisitanteCriado();

            Console.WriteLine("VISITANTE CRIADO INICIO -> " + visitanteCriado.ToString());

            SqlCommand cmd = new SqlCommand("AddVisitante", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = cn;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@cartao_cidadao", visitanteCriado.Cartao_cidadao); 
            cmd.Parameters.AddWithValue("@nome", visitanteCriado.Nome);



            Console.WriteLine("VISITANTE CRIADO FINAL -> " + visitanteCriado.ToString());
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Registo do novo visitante falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }


        private bool setVisitanteCriado()
        {
            if (!comNovoVisitante)
                return false;

            visitanteCriado.Cartao_cidadao = textCCVisitante.Text;
            visitanteCriado.Nome = textNomeVisitante.Text;

            return true;
        }


        public void addVisita()
        {
            if (!verifySGBDConnection())
                 return;

            Utente u = utenteSelecionado; // utente visitado
            Visitante v = new Visitante();

            // visitante: novo ou existente no sistema
            if (comNovoVisitante)
                v = visitanteCriado;
            else if (!comNovoVisitante)
                v = visianteSelecionado;

            visitanteInserido = v;

            Visita novaVisita = new Visita();

            novaVisita.No_utente = Int32.Parse(u.No_utente);
            novaVisita.Nome_utente = u.Nome;
            novaVisita.Nome_visitante = v.Nome;
            novaVisita.Cc_visitante = v.Cartao_cidadao;
            novaVisita.Data = DateTime.Today.ToString().Split(null)[0];
            novaVisita.Hora_entrada = DateTime.Now.ToString("HH:mm");

            //String cuidado = comboBoxCuidados.GetItemText(idxCuidadoAtual);

            SqlCommand cmd = new SqlCommand("AddVisita", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@no_utente", novaVisita.No_utente);
            cmd.Parameters.AddWithValue("@cc_visitante", novaVisita.Cc_visitante);
            cmd.Parameters.AddWithValue("@data", DateTime.Parse(novaVisita.Data));
            cmd.Parameters.AddWithValue("@hora_entrada", DateTime.Parse(novaVisita.Hora_entrada));
            //cmd.Parameters.AddWithValue("@hora_saida", Int32.Parse(utente.No_utente));

            Console.WriteLine("Visita antes do INSERT: " + novaVisita.ToString());

            visitaInserida = novaVisita;


            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Adição da visita falhou. \n ERRO: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        } 


        // -------------------------------------------------- OUTRAS --------------------------------------------------

        public void ClearFields()
        {
            textNomeVisitante.Text = "";
            textCCVisitante.Text = "";

        }


        public void showNovoVisitante()
        {
            painelNovoVisitante.Show();
            /*labelNomeVisitante.Show();
            textNomeVisitante.Show();
            labelCCVisitante.Show();
            textCCVisitante.Show();*/
        }

        public void hideNovoVisitante()
        {
            painelNovoVisitante.Hide();
            /*labelNomeVisitante.Hide();
            textNomeVisitante.Hide();
            labelCCVisitante.Hide();
            textCCVisitante.Hide();*/

        }

        public void showVisitanteExistente()
        {
            labelSelecVisitante.Show();
            comboBoxVisitantes.Show();
        }

        public void hideVisitanteExistente()
        {
            labelSelecVisitante.Hide();
            comboBoxVisitantes.Hide();
            showNovoVisitante();
        }


        private void ComboBoxVisitantes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxVisitantes.SelectedIndex >= 0)
            {

                idxVisitanteSelecionado = comboBoxVisitantes.SelectedIndex;
                visianteSelecionado = (Visitante)comboBoxVisitantes.Items[idxVisitanteSelecionado];
                Console.WriteLine("Visitante atual visita popup: " + visianteSelecionado.ToString());
            }
        }

        private void TitleNovoUtente_Click(object sender, EventArgs e)
        {

        }

        private void RadioButtonVisitExistente_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButtonVisitExistente.Checked)
            {
                comboBoxVisitantes.Enabled = true;
                showVisitanteExistente();
                hideNovoVisitante();
                comNovoVisitante = false;
            }
            else
            {
                hideVisitanteExistente();
                showNovoVisitante();
                comNovoVisitante = true;
            }
        }

        private void RadioButtonNovoVisitante_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButtonNovoVisitante.Checked)
            {
                hideVisitanteExistente();
                showNovoVisitante();
                comNovoVisitante = true;
            }
            else
            {
                showVisitanteExistente();
                hideNovoVisitante();
                comNovoVisitante = false;
            }
        }

        private void BotaoCancelar_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }
    }
}
