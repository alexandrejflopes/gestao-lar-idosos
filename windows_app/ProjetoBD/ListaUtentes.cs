using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ProjetoBD
{
    public partial class ListaUtentes : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;

        private int utenteAtual;
        private Utente utenteSelecionado;
        private ListBox listaAllUtentes;

        public int UtenteAtual { get => utenteAtual; set => utenteAtual = value; }

        public ListBox ListaAllUtentes { get => listaAllUtentes; set => listaAllUtentes = value; }
        public ListaUtentes()
        {
            baseDados = new Ligacao();

            InitializeComponent();
            cn = getSGBDConnection();
            loadUtentesOnStart();
            listaAllUtentes = listBoxUtentes;

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


        // --------------------------------------------------  SETUP ----------------------------------
        private void loadUtentesOnStart()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("SELECT * from GetUtentes()", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBoxUtentes.Items.Clear();

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

                listBoxUtentes.Items.Add(U);

            }

            textTotalUtentes.Text = listBoxUtentes.Items.Count.ToString();

            cn.Close();


            utenteAtual = 0; // primeiro utente da lista
            LockControls();
            ShowUtente();
        }
        private void Button2_Click(object sender, EventArgs e)
        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();
        }
        // ---------------------------------------------------------------------------------------------





        // --------------------------------------------------  BOTOES ----------------------------------
        private void verMais_Click(object sender, EventArgs e)
        {
            Utente u_selecionado = (Utente)listBoxUtentes.Items[utenteAtual];

            Console.WriteLine("Utente atual (depois do ver mais): " + u_selecionado.ToString());
            UtentePage utente = new UtentePage(u_selecionado);
            utente.ListaUtentes = listBoxUtentes;
            utente.UtenteIndex = utenteAtual;
            utente.Show();
            this.Hide();
        }

        private void BttnDelete_Click(object sender, EventArgs e)
        {
            if (listBoxUtentes.SelectedIndex > -1)
            {
                try
                {
                    RemoveUtente(utenteSelecionado);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                listBoxUtentes.Items.RemoveAt(listBoxUtentes.SelectedIndex);
                if (utenteAtual == listBoxUtentes.Items.Count)
                    utenteAtual = listBoxUtentes.Items.Count - 1;
                if (utenteAtual == -1)
                {
                    ClearFields();
                    MessageBox.Show("Não há mais utentes!");
                }
                else
                {
                    MessageBox.Show("Utente eliminado com sucesso!");
                    textTotalUtentes.Text = listBoxUtentes.Items.Count.ToString();
                    ShowUtente();
                }
            }
        }

        // ---------------------------------------------------------------------------------------------



        // --------------------------------------------------------   OUTRAS   -------------------------------------------

        public void ClearFields()
        {
            txtID.Text = "";
            txtNome.Text = "";
            txtAlcunha.Text = "";
            txtNasc.Text = "";
            txtSexo.Text = "";

        }

        public void LockControls()
        {
            txtID.ReadOnly = true;
            txtID.ReadOnly = true;
            txtNome.ReadOnly = true;
            txtAlcunha.ReadOnly = true;
            txtNasc.ReadOnly = true;
            txtSexo.ReadOnly = true;
        }
        private void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBoxUtentes.SelectedIndex >= 0)
            {
                utenteAtual = listBoxUtentes.SelectedIndex;
                utenteSelecionado = (Utente)listBoxUtentes.Items[utenteAtual];
                ShowUtente();
                Console.WriteLine("Utente atual: " + ((Utente)listBoxUtentes.Items[utenteAtual]).ToString());
            }
        }

        public void ShowUtente()
        {
            if (listBoxUtentes.Items.Count == 0 | utenteAtual < 0)
                return;
            Utente utente = new Utente();
            utente = (Utente)listBoxUtentes.Items[utenteAtual];
            txtID.Text = utente.No_utente;
            txtNome.Text = utente.Nome;
            txtAlcunha.Text = utente.Alcunha;
            txtNasc.Text = utente.Data_nasc.Split(null)[0];
            txtSexo.Text = utente.Sexo;

        }

        private void RemoveUtente(Utente u)
        {
            if (!verifySGBDConnection())
                return;
          
            SqlCommand cmd = new SqlCommand("RemoveUtente", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@no_utente", Convert.ToInt32(u.No_utente));

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Remoção do utente falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }



        // --------------------------------------------------------   LIXO   -------------------------------------------

        private void Label4_Click(object sender, EventArgs e)
        {
            
        }

        private void TxtNasc_TextChanged(object sender, EventArgs e)
        {

        }

        

        

        private void Label2_Click(object sender, EventArgs e)
        {

        }

        private void ButtonAddUtente_Click(object sender, EventArgs e)
        {
            novoUtente novoUtente = new novoUtente(ListaAllUtentes);
            novoUtente.Show();
            this.Hide();
        }

        private void ListaUtentes_FormClosing(object sender, FormClosingEventArgs e)
        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();
        }
    }
}
