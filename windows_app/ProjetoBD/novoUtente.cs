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
    public partial class novoUtente : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;


        private int idxQuartoAtual;
        private Quarto quartoSelecionado;
        private int idxRespAtual;
        private Responsavel responsavelSelecionado;

        private Utente utenteCriado;
        private Utente utenteAdicionado;
        private Responsavel responsavelCriado;
        private bool comQuarto;
        private bool comCasa;
        private bool comNovoResp;

        private ListBox listaUtentes;


        public novoUtente(ListBox listaDeUtentes)
        {
            baseDados = new Ligacao();

            InitializeComponent();
            cn = getSGBDConnection();
            utenteCriado = new Utente();
            utenteAdicionado = new Utente();
            responsavelCriado = new Responsavel();
            listaUtentes = listaDeUtentes;
            //ClearFields();

            setupQuartos();
            setupResponsaveis();

            lockItensCasa();
            lockItensQuarto();

            showItensQuarto();
            hideItensCasa();

            comboBoxSelecResp.Enabled = false;
            hideNovoResp();
            showRespExistente();

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


        // -------------------------------------------------- SETUP ---------------------------------------------------

        public void setupQuartos()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from getAllQuartos() order by numero";
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxQuartos.Items.Clear();

            while (reader.Read())
            {
                Quarto Q = new Quarto();
                Q.Id = (int)reader["id"];
                Q.Numero = (int)reader["numero"];
                Q.Detalhes = reader["detalhes"].ToString();

                comboBoxQuartos.Items.Add(Q);

            }
            reader.Close();
            cn.Close();

        }

        public void setupResponsaveis()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from GetResponsaveis() order by nome";
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxSelecResp.Items.Clear();

            while (reader.Read())
            {
                Responsavel R = new Responsavel();
                R.Cc = reader["cartao_cidadao"].ToString();
                R.Nome = reader["nome"].ToString();
                R.Morada = reader["morada"].ToString();
                R.Tipo = reader["tipo"].ToString();
                R.Telemovel = reader["numero_telefone"].ToString();
                

                comboBoxSelecResp.Items.Add(R);

            }
            reader.Close();
            cn.Close();

        }


        // -------------------------------------------------- BOTOES --------------------------------------------------


        private void RadioButtonCasa_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButtonCasa.Checked)
            {
                unlockItensCasa();
                showItensCasa();
                hideItensQuarto();
                comCasa = true;
                comQuarto = false;
            }
            else
            {
                hideItensCasa();
                showItensQuarto();
                comQuarto = true;
                comCasa = false;
            }
        }

        private void RadioButtonQuarto_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButtonQuarto.Checked)
            {
                unlockItensQuarto();
                hideItensCasa();
                showItensQuarto();
                comQuarto = true;
                comCasa = false;
            }
            else
            {
                showItensCasa();
                hideItensQuarto();
                comCasa = true;
                comQuarto = false;
            }
        }


        private void RadioButtonRespExistente_CheckedChanged_1(object sender, EventArgs e)
        {
            if (radioButtonRespExistente.Checked)
            {
                comboBoxSelecResp.Enabled = true;
                showRespExistente();
                hideNovoResp();
                comNovoResp = false;
            }
            else
            {
                hideRespExistente();
                showNovoResp();
                comNovoResp = true;
            }
        }

        private void RadioButtonNovoResp_CheckedChanged_1(object sender, EventArgs e)
        {
            if (radioButtonNovoResp.Checked)
            {
                hideRespExistente();
                showNovoResp();
                comNovoResp = true;
            }
            else
            {
                showRespExistente();
                hideNovoResp();
                comNovoResp = false;
            }
        }



        private void ButtonRegistarUtente_Click(object sender, EventArgs e)
        {
            /*try
            {
                Console.WriteLine("textNIF.Text -> " + textNIF.Text);
                if (comNovoResp)
                {
                    
                    setResponsavelCriado();
                    AddNovoResponsavel();
                    
                }
                
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }*/

            Console.WriteLine("textNIF.Text -> " + textNIF.Text);
            if (comNovoResp)
            {
                setResponsavelCriado();
                AddNovoResponsavel();
            }

            setUtenteCriado();
            SubmitUtente();

            setUtenteAdicionado();
            listaUtentes.Items.Add(utenteAdicionado);
            Console.WriteLine("Utente criado (depois do ADD): " + utenteCriado.ToString());
            ListaUtentes utentes = new ListaUtentes();
            utentes.ListaAllUtentes = listaUtentes;
            utentes.Show();
            this.Hide();

        }

        // ------------------------------------------------------------------------------------------------------------





        // -------------------------------------------------- OUTRAS --------------------------------------------------

        public void ClearFields()
        {
            textNome.Text = "";
            textAlcunha.Text = "";
            textNIF.Text = "";
            textPhone.Text = "";
            textMoradaAnterior.Text = "";
            textMoradaAtual.Text = "";
            textNIF.Text = "";
            textNISS.Text = "";
            textBoxNomeResp.Text = "";
            textBoxCCResp.Text = "";
            textBoxMoradaResp.Text = "";
            textBoxPhoneResp.Text = "";
            textPhoneCasa.Text = "";
            textSNS.Text = "";

        }

        public void hideItensCasa()
        {
            labelMoradaAtual.Hide();
            textMoradaAtual.Hide();
            labelPhoneCasa.Hide();
            textPhoneCasa.Hide();
        }

        public void lockItensCasa()
        {
            textMoradaAtual.ReadOnly = true;
            textPhoneCasa.ReadOnly = true;
        }

        public void unlockItensCasa()
        {
            textMoradaAtual.ReadOnly = false;
            textPhoneCasa.ReadOnly = false;
        }
        public void showItensCasa()
        {
            labelMoradaAtual.Show();
            textMoradaAtual.Show();
            labelPhoneCasa.Show();
            textPhoneCasa.Show();
        }

        public void lockItensQuarto()
        {
            textMoradaAnterior.ReadOnly = true;
            comboBoxQuartos.Enabled = false;
        }

        public void unlockItensQuarto()
        {
            textMoradaAnterior.ReadOnly = false;
            comboBoxQuartos.Enabled = true;
        }

        public void hideItensQuarto()
        {
            labelMoradaAnterior.Hide();
            textMoradaAnterior.Hide();
            labelQuarto.Hide();
            comboBoxQuartos.Hide();
        }

        public void showItensQuarto()
        {
            labelMoradaAnterior.Show();
            textMoradaAnterior.Show();
            labelQuarto.Show();
            comboBoxQuartos.Show();
        }

        public void showNovoResp()
        {
            painelNovoResp.Show();
        }

        public void hideNovoResp()
        {
            painelNovoResp.Hide();
        }

        public void showRespExistente()
        {
            labelSelecResp.Show();
            comboBoxSelecResp.Show();
        }

        public void hideRespExistente()
        {
            labelSelecResp.Hide();
            comboBoxSelecResp.Hide();
            showNovoResp();
        }

        private void ComboBoxQuartos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxQuartos.SelectedIndex >= 0)
            {
                idxQuartoAtual = comboBoxQuartos.SelectedIndex;
                quartoSelecionado = (Quarto)comboBoxQuartos.Items[idxQuartoAtual];
                Console.WriteLine("Quarto selecionado: " + quartoSelecionado.ToString());
            }
        }

        private void ComboBoxSelecResp_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxSelecResp.SelectedIndex >= 0)
            {
                idxRespAtual = comboBoxSelecResp.SelectedIndex;
                responsavelSelecionado = (Responsavel)comboBoxSelecResp.Items[idxRespAtual];
                Console.WriteLine("Responsavel selecionado: " + responsavelSelecionado.ToString());
            }
        }



        private void SubmitUtente()
        {
            if (!verifySGBDConnection())
                return;

            /*try
            {
                setUtenteCriado();
                Console.WriteLine("Utente criado criado!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
                
            }*/

            
            Console.WriteLine("UTENTE CRIADO INICIO -> " + utenteCriado.ToString());

            SqlCommand cmd = new SqlCommand("AddUtente", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = cn;
            //cmd.Parameters.Clear();
            //cmd.Parameters.AddWithValue("@no_utente", Convert.ToInt32(utenteCriado.No_utente)); // autogerado
            cmd.Parameters.AddWithValue("@cc_resp", utenteCriado.Cc_responsavel);
            cmd.Parameters.AddWithValue("@nome", utenteCriado.Nome);
            //cmd.Parameters.AddWithValue("@fotografia", "null"); // nao vamos alterar a foto por argumento
            cmd.Parameters.AddWithValue("@alcunha", utenteCriado.Alcunha);
            cmd.Parameters.AddWithValue("@data_nasc", utenteCriado.Data_nasc);
            Console.WriteLine("Data Nasc INSERT -> " + utenteCriado.Data_nasc);
            //Console.WriteLine("Data Nasc INSERT -> " + DateTime.Parse(utenteCriado.Data_nasc));

            cmd.Parameters.AddWithValue("@sexo", utenteCriado.Sexo);
            Console.WriteLine("Sexo INSERT -> " + utenteCriado.Sexo);
            cmd.Parameters.AddWithValue("@estado_civil", utenteCriado.Estado_civil);
            Console.WriteLine("Estado civil INSERT -> " + utenteCriado.Estado_civil);

            cmd.Parameters.AddWithValue("@NIF", utenteCriado.NIF);        

            cmd.Parameters.AddWithValue("@data_entrada", utenteCriado.Data_entrada);
            Console.WriteLine("Data Entrada INSERT -> " + utenteCriado.Data_entrada);
            //Console.WriteLine("Data Entrada INSERT -> " + DateTime.Parse(utenteCriado.Data_entrada));

            cmd.Parameters.AddWithValue("@sns", utenteCriado.Sns);
            cmd.Parameters.AddWithValue("@niss", utenteCriado.Niss);
            cmd.Parameters.AddWithValue("@subsistema_saude", utenteCriado.Subsistema_saude);
            Console.WriteLine("Sub Saude INSERT -> " + utenteCriado.Subsistema_saude);

            cmd.Parameters.AddWithValue("@grau_dependencia", utenteCriado.Grau_dependencia);
            Console.WriteLine("Grau Dep INSERT -> " + utenteCriado.Grau_dependencia);

            if (textPhone.Text.Length == 9)
                cmd.Parameters.AddWithValue("@num_telemovel", utenteCriado.Num_telemovel);

            // se for para ir para um quarto
            if (comQuarto)
            {
                cmd.Parameters.AddWithValue("@morada_anterior", utenteCriado.Morada_anterior);
                cmd.Parameters.AddWithValue("@numero", quartoSelecionado.Numero);
            }
            // se ficar em casa
            if (comCasa)
            {
                cmd.Parameters.AddWithValue("@morada", textMoradaAtual.Text);
                cmd.Parameters.AddWithValue("@num_tel", textPhoneCasa.Text);
            }

            Console.WriteLine("UTENTE CRIADO FINAL -> " + utenteCriado.ToString());
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Registo do utente falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }

        private void AddNovoResponsavel()
        {
            if (!verifySGBDConnection())
                return;

            try
            {
                setUtenteCriado();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;

            }


            Console.WriteLine("RESPONSAVEL CRIADO INICIO -> " + responsavelCriado.ToString());

            SqlCommand cmd = new SqlCommand("AddResponsavel", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Connection = cn;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@cartao_cidadao", responsavelCriado.Cc); 
            cmd.Parameters.AddWithValue("@nome", responsavelCriado.Nome);
            cmd.Parameters.AddWithValue("@morada", responsavelCriado.Morada);
            cmd.Parameters.AddWithValue("@tipo", responsavelCriado.Tipo);
            cmd.Parameters.AddWithValue("@numero_telefone", responsavelCriado.Telemovel);
            

            Console.WriteLine("RESPONSAVEL CRIADO FINAL -> " + responsavelCriado.ToString());
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Registo do responsável falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }

        private bool setResponsavelCriado()
        {
            if (!comNovoResp)
                return false;

            responsavelCriado.Cc = textBoxCCResp.Text;
            responsavelCriado.Nome = textBoxNomeResp.Text;
            responsavelCriado.Morada = textBoxMoradaResp.Text;
            responsavelCriado.Tipo = comboBoxTipoResp.Items[comboBoxTipoResp.SelectedIndex].ToString();
            responsavelCriado.Telemovel = textBoxPhoneResp.Text;

            return true;
        }

        private void setUtenteCriado()
        {
            utenteCriado.Nome = textNome.Text;

            // responsavel
            if(comNovoResp)
                utenteCriado.Cc_responsavel = textBoxCCResp.Text;
            else if(!comNovoResp)
                utenteCriado.Cc_responsavel = responsavelSelecionado.Cc;

            //utenteCriado.No_utente = textNo_utente.Text;

            utenteCriado.Data_entrada = DateTime.Today.ToString().Split(null)[0]; // data da insercao
            //utenteCriado.Id_alojamento = textIDAloj.Text;
            utenteCriado.Alcunha = textAlcunha.Text;
            utenteCriado.Sexo = comboBoxSexo.Items[comboBoxSexo.SelectedIndex].ToString();

            utenteCriado.Data_nasc = dateNascPicker.Value.ToString("yyyy-MM-dd");
            Console.WriteLine("Data Nasc do setup -> " + utenteCriado.Data_nasc);
            
            utenteCriado.Estado_civil = comboBoxEstadoCivil.Items[comboBoxEstadoCivil.SelectedIndex].ToString();
            utenteCriado.NIF = textNIF.Text;
            Console.WriteLine("textNIF.Text -> " + textNIF.Text);
            
            utenteCriado.Subsistema_saude = comboBoxSubSaude.Items[comboBoxSubSaude.SelectedIndex].ToString();
            utenteCriado.Sns = textSNS.Text;
            utenteCriado.Niss = textNISS.Text;
            utenteCriado.Grau_dependencia = comboBoxGrauDep.Items[comboBoxGrauDep.SelectedIndex].ToString();

            // caso tenha numero de telemovel, definir numero de telemovel
            if (textPhone.Text.Length == 9)
                utenteCriado.Num_telemovel = textPhone.Text;

            // se tem quarto, fornecer definir morada anterior
            if (comQuarto)
                utenteCriado.Morada_anterior = textMoradaAnterior.Text;
        }

        private void setUtenteAdicionado()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from GetUtentes() where NIF = " + utenteCriado.NIF;
            cmd.Connection = cn;
            Console.WriteLine("Comand SQL SELECT UTENTE CRIADO -> " + cmd.CommandText);
            Console.WriteLine("utenteCriado.NIF -> " + utenteCriado.NIF);

            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxQuartos.Items.Clear();

            while (reader.Read())
            {
                utenteAdicionado.No_utente = reader["no_utente"].ToString();
                utenteAdicionado.Cc_responsavel = reader["cc_responsavel"].ToString();
                utenteAdicionado.Id_alojamento = reader["id_alojamento"].ToString();
                utenteAdicionado.Nome = reader["nome"].ToString();
                utenteAdicionado.Fotografia = reader["fotografia"].ToString();
                utenteAdicionado.Alcunha = reader["alcunha"].ToString();
                utenteAdicionado.Data_nasc = reader["data_nasc"].ToString();
                utenteAdicionado.Sexo = reader["sexo"].ToString();
                utenteAdicionado.Estado_civil = reader["estado_civil"].ToString();
                utenteAdicionado.NIF = reader["NIF"].ToString();
                utenteAdicionado.Morada_anterior = reader["morada_anterior"].ToString();
                utenteAdicionado.Data_entrada = reader["data_entrada"].ToString();
                utenteAdicionado.Sns = reader["sns"].ToString();
                utenteAdicionado.Niss = reader["niss"].ToString();
                utenteAdicionado.Subsistema_saude = reader["subsistema_saude"].ToString();
                utenteAdicionado.Grau_dependencia = reader["grau_dependencia"].ToString();
                utenteAdicionado.Num_telemovel = reader["num_telemovel"].ToString();

                break; // para o caso de acontecer haver mais tuplos
               
            }

            Console.WriteLine("Utente adicionado -> " + utenteAdicionado.ToString());
            reader.Close();
            cn.Close();
        }

        private void TitleNovoUtente_Click(object sender, EventArgs e)
        {

        }

        private void BotaoCancelar_Click(object sender, EventArgs e)
        {
            ListaUtentes utentes = new ListaUtentes();
            utentes.Show();
            this.Hide();
        }

        private void NovoUtente_Load(object sender, EventArgs e)
        {

        }

        private void NovoUtente_FormClosing(object sender, FormClosingEventArgs e)

        {
            ListaUtentes utentes = new ListaUtentes();
            utentes.Show();
            this.Hide();

        }

        private void BotaoCancelar_Click_1(object sender, EventArgs e)
        {
            ListaUtentes utentes = new ListaUtentes();
            utentes.Show();
            this.Hide();
        }






        // -----------------------------------------------------------------------------------------------------------
    }
}
