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
    public partial class Enfermeiros : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;

        private int idxEnfermeiroAtual;
        private Enfermeiro enfermeiroSelecionado;

        public Enfermeiros()
        {
            baseDados = new Ligacao();
            InitializeComponent();
            loadEnfermeirosOnStart();
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



        // -------------------------------------------------- OUTRAS --------------------------------------------------

        public void ClearFields()
        {
            textNome.Text = "";
            textNIF.Text = "";
            textPhone.Text = "";
            textSexo.Text = "";
            textNasc.Text = "";
            textOrdem.Text = "";

        }

        public void AllowEdits()
        {
            botaoEditEnfermeiro.Hide();
            botaoEliminarEnfermeiro.Hide();
            botaoGuardar.Show();
            botaoCancelar.Show();
            textNome.Enabled = false;
            textOrdem.Enabled = false;
            textNIF.Enabled = false;
            textNasc.Enabled = false;
            textSexo.Enabled = false;
            textPhone.Enabled = true;
            textPhone.ReadOnly = false;
            listBoxEnfermeiros.Enabled = false;
        }

        public void LockEdits()
        {
            botaoEditEnfermeiro.Show();
            botaoEliminarEnfermeiro.Show();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            textNome.Enabled = false;
            textOrdem.Enabled = false;
            textNIF.Enabled = false;
            textNasc.Enabled = false;
            textSexo.Enabled = false;
            textPhone.Enabled = false;
            listBoxEnfermeiros.Enabled = true;
        }


        public void AllowAddEdits()
        {

            botaoEditEnfermeiro.Hide();
            botaoEliminarEnfermeiro.Hide();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            botaoGuardarAdd.Show();
            botaoCancelarAdd.Show();
            labelNoEmpregado.Hide();
            textID.Hide();
            labelNovoEnf.Show();
            textNome.Enabled = true;
            textNome.ReadOnly = false;
            textOrdem.Enabled = true;
            textOrdem.ReadOnly = false;
            textNIF.Enabled = true;
            textNIF.ReadOnly = false;
            dateTimePicker1.Show();
            textNasc.Hide();
            comboBoxSexo.Show();
            textSexo.Hide();
            textPhone.Enabled = true;
            textPhone.ReadOnly = false;
            listBoxEnfermeiros.Enabled = false;
        }

        public void LockAddEdits()
        {
            labelNoEmpregado.Show();
            textID.Show();
            labelNovoEnf.Hide();

            botaoEditEnfermeiro.Show();
            botaoEliminarEnfermeiro.Show();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            botaoGuardarAdd.Hide();
            botaoCancelarAdd.Hide();

            textNome.Enabled = false;
            textNIF.Enabled = false;
            textOrdem.Enabled = false;

            dateTimePicker1.Hide();
            textNasc.Show();
            textNasc.Enabled = false;

            comboBoxSexo.Hide();
            textSexo.Show();
            textSexo.Enabled = false;

            textPhone.Enabled = false;

            listBoxEnfermeiros.Enabled = true;

        }

        public void loadEnfermeirosOnStart()
        {
            if (!verifySGBDConnection())
                return;

            try
            {
                String caminhoPadrao = "C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/idosos_cara/placeholder.png";
                funcionarioFoto.Image = Image.FromFile(caminhoPadrao);
            }
            catch (Exception)
            {
                funcionarioFoto.Image = funcionarioFoto.ErrorImage;
            }


            SqlCommand cmd = new SqlCommand("SELECT * from GetEnfermeiros()  order by num_id", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBoxEnfermeiros.Items.Clear();

            while (reader.Read())
            {
                Enfermeiro E = new Enfermeiro();
                E.Id = (int)reader["num_id"];
                E.Nome = reader["nome"].ToString();
                E.Nif = reader["nif"].ToString();
                E.Data_nasc = reader["data_nasc"].ToString().Split(null)[0];
                E.Sexo = reader["sexo"].ToString();
                E.Telefone = reader["num_telefone"].ToString();
                E.Num_ordem_enfermeiros = (int)reader["num_ordem_enfermeiros"];


                listBoxEnfermeiros.Items.Add(E);

            }

            textTotalEnfermeiros.Text = listBoxEnfermeiros.Items.Count.ToString();

            cn.Close();

            // primeiro funcionario da lista
            idxEnfermeiroAtual = 0;
            enfermeiroSelecionado = (Enfermeiro)listBoxEnfermeiros.Items[idxEnfermeiroAtual];
            LockEdits();
            LockAddEdits();
            ShowEnfermeiro();
        }



        private void UpdateEnfermeiro(Enfermeiro enf)
        {
            int rows = 0;

            Console.WriteLine("Entrei no update -> " + enf.Id + " | " + enf.Nome + " | " + enf.Nif + " | " + enf.Data_nasc + " | " + enf.Sexo + " | " + enf.Telefone);

            if (!verifySGBDConnection())
                return;

            Console.WriteLine("Conexão -> " + cn.State);

            SqlCommand cmd = new SqlCommand("AlterEnfermeiro", cn);
            Console.WriteLine("Passei na conexao");
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Clear();

            Console.WriteLine("ENFERMEIRO\n" + enf.Id + " | " + enf.Nome + " | " + enf.Nif + " | " + enf.Data_nasc + " | " + enf.Sexo + " | " + enf.Telefone);

            cmd.Parameters.AddWithValue("@num_id", enf.Id);
            cmd.Parameters.AddWithValue("@nome", enf.Nome);
            cmd.Parameters.AddWithValue("@nif", enf.Nif);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(enf.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", enf.Sexo);
            cmd.Parameters.AddWithValue("@num_telefone", enf.Telefone);
            cmd.Parameters.AddWithValue("@num_ordem_enfermeiros", enf.Num_ordem_enfermeiros);


            Console.WriteLine("Paramentros fornecidos");

            //cmd.Connection = cn;

            try
            {
                rows = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Atualização de dados falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                Console.WriteLine("ROWS UPDATE -> " + rows);
                if (rows == 6 || rows == 7) // com ou sem foto
                    MessageBox.Show("Dados atualizados com sucesso.");
                else
                    MessageBox.Show("Dados atualizados sem sucesso.");

                cn.Close();
            }
        }

        private void SubmitEnfermeiro(Enfermeiro enf)
        {
            int rows = 0;
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("AddEnfermeiro", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Clear();

            cmd.Parameters.Clear();
            //cmd.Parameters.AddWithValue("@num_id", func.Id);
            cmd.Parameters.AddWithValue("@nome", enf.Nome);
            cmd.Parameters.AddWithValue("@nif", enf.Nif);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(enf.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", enf.Sexo);
            cmd.Parameters.AddWithValue("@num_telefone", enf.Telefone);
            cmd.Parameters.AddWithValue("@num_ordem_enfermeiros", enf.Num_ordem_enfermeiros);
            //cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Registo de enfermeiro falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                if (rows == 2)
                    MessageBox.Show("Dados atualizados com sucesso.");
                else
                    MessageBox.Show("Dados atualizados com sucesso.");
                cn.Close();
            }
        }


        private bool SaveNovoEnfermeiro()
        {
            Enfermeiro novoEnfermeiro = new Enfermeiro();
            try
            {

                Console.WriteLine("Entrei no TRY Save Novo");
                //novoFuncionario.Id = 202;//Convert.ToInt32(textID.Text);
                novoEnfermeiro.Nome = textNome.Text;
                novoEnfermeiro.Nif = textNIF.Text;
                novoEnfermeiro.Sexo = comboBoxSexo.Items[comboBoxSexo.SelectedIndex].ToString();
                novoEnfermeiro.Data_nasc = dateTimePicker1.Value.ToString("yyyy-MM-dd");
                novoEnfermeiro.Telefone = textPhone.Text;
                novoEnfermeiro.Num_ordem_enfermeiros = Convert.ToInt32(textOrdem.Text);


            }

            catch (Exception ex)
            {
                MessageBox.Show("Save NOVO Enfermeiro -> " + novoEnfermeiro.ToString() + "\n" + ex.Message);
                return false;
            }

            Console.WriteLine("novoAddEnfermeiro -> " + novoEnfermeiro.Id + " | " + novoEnfermeiro.Nome + " | " + novoEnfermeiro.Nif + " | " + novoEnfermeiro.Data_nasc + " | " + novoEnfermeiro.Sexo + " | " + novoEnfermeiro.Telefone + " | " + novoEnfermeiro.Num_ordem_enfermeiros);

            SubmitEnfermeiro(novoEnfermeiro);

            Console.WriteLine("Depois do Update Enfermeiro");

            listBoxEnfermeiros.Items.Add(novoEnfermeiro);
            loadEnfermeirosOnStart();
            return true;
        }


        private bool SaveEnfermeiro()
        {
            Enfermeiro novoEnfermeiro = new Enfermeiro();
            try
            {
                novoEnfermeiro.Id = Convert.ToInt32(textID.Text);
                novoEnfermeiro.Nome = textNome.Text;
                novoEnfermeiro.Nif = textNIF.Text;
                novoEnfermeiro.Sexo = textSexo.Text;
                novoEnfermeiro.Data_nasc = textNasc.Text;
                novoEnfermeiro.Telefone = textPhone.Text;
                novoEnfermeiro.Num_ordem_enfermeiros = Convert.ToInt32(textOrdem.Text);
            }

            catch (Exception ex)
            {
                MessageBox.Show("Save Enfermeiro -> " + ex.Message);
                return false;
            }

            Console.WriteLine("novoEnfermeiro -> " + novoEnfermeiro.Id + " | " + novoEnfermeiro.Nome + " | " + novoEnfermeiro.Nif + " | " + novoEnfermeiro.Data_nasc + " | " + novoEnfermeiro.Sexo + " | " + novoEnfermeiro.Telefone);

            UpdateEnfermeiro(novoEnfermeiro);

            Console.WriteLine("Depois do Update Enfermeiro");

            listBoxEnfermeiros.Items[idxEnfermeiroAtual] = novoEnfermeiro;
            return true;
        }



        private void RemoveEnfermeiro(Enfermeiro enf)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("RemoveEmpregado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@num_id", Convert.ToInt32(enf.Id));

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Remoção do enfermeiro falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }


        public void ShowEnfermeiro()
        {
            if (listBoxEnfermeiros.Items.Count == 0 | idxEnfermeiroAtual < 0)
                return;

            textID.Text = enfermeiroSelecionado.Id.ToString();
            textNome.Text = enfermeiroSelecionado.Nome;
            textNIF.Text = enfermeiroSelecionado.Nif;
            textNasc.Text = enfermeiroSelecionado.Data_nasc.Split(null)[0];
            textSexo.Text = enfermeiroSelecionado.Sexo;
            textPhone.Text = enfermeiroSelecionado.Telefone;
            textOrdem.Text = enfermeiroSelecionado.Num_ordem_enfermeiros.ToString();

        }





        // -------------------------------------------------- BOTOES --------------------------------------------------

        private void ListBoxEnfermeiros_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBoxEnfermeiros.SelectedIndex >= 0)
            {
                idxEnfermeiroAtual = listBoxEnfermeiros.SelectedIndex;
                enfermeiroSelecionado = (Enfermeiro)listBoxEnfermeiros.Items[idxEnfermeiroAtual];
                ShowEnfermeiro();
                Console.WriteLine("Enfermeiro atual: " + enfermeiroSelecionado.ToString());
            }
        }

        private void BotaoEditEnfermeiro_Click(object sender, EventArgs e)
        {

            if (idxEnfermeiroAtual < 0)
            {
                MessageBox.Show("Selecione um enfermeiro para editar.");
                return;
            }

            AllowEdits();

        }

        private void BotaoCancelar_Click(object sender, EventArgs e)
        {
            LockEdits();
        }

        private void BotaoGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Console.WriteLine("Entrei no TRY");
                SaveEnfermeiro();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Logo ao Clicar -> " + ex.Message);
            }

            //SaveFuncionario();
            listBoxEnfermeiros.Enabled = true;
            int idx = listBoxEnfermeiros.FindString(textID.Text);
            Console.WriteLine("idx -> " + idx);
            listBoxEnfermeiros.SelectedIndex = idx;
            LockEdits();
        }

        private void BotaoGuardarAdd_Click(object sender, EventArgs e)
        {
            try
            {
                Console.WriteLine("Entrei no TRY ADD");
                SaveNovoEnfermeiro();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Logo ao Clicar ADD -> " + ex.Message);
            }

            //SaveFuncionario();
            listBoxEnfermeiros.Enabled = true;
            int idx = listBoxEnfermeiros.FindString(textID.Text);
            Console.WriteLine("idx -> " + idx);
            listBoxEnfermeiros.SelectedIndex = idx;
            textTotalEnfermeiros.Text = listBoxEnfermeiros.Items.Count.ToString();
            LockAddEdits();
        }
        private void BotaoCancelarAdd_Click(object sender, EventArgs e)
        {
            if (listBoxEnfermeiros.Items.Count > 0)
            {
                idxEnfermeiroAtual = listBoxEnfermeiros.SelectedIndex;
                if (idxEnfermeiroAtual < 0)
                    idxEnfermeiroAtual = 0;

                enfermeiroSelecionado = (Enfermeiro)listBoxEnfermeiros.Items[idxEnfermeiroAtual];
                ShowEnfermeiro();
            }
            LockAddEdits();
        }

        private void ButtonAddEnfermeiro_Click(object sender, EventArgs e)
        {
            ClearFields();
            AllowAddEdits();
        }

        private void BotaoSair_Click(object sender, EventArgs e)
        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();
        }

        private void Enfermeiros_FormClosing(object sender, FormClosingEventArgs e)

        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();

        }

        private void BotaoEliminarEnfermeiro_Click(object sender, EventArgs e)
        {
            if (listBoxEnfermeiros.SelectedIndex > -1)
            {
                try
                {
                    RemoveEnfermeiro(enfermeiroSelecionado);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                listBoxEnfermeiros.Items.RemoveAt(listBoxEnfermeiros.SelectedIndex);
                if (idxEnfermeiroAtual == listBoxEnfermeiros.Items.Count)
                    idxEnfermeiroAtual = listBoxEnfermeiros.Items.Count - 1;
                if (idxEnfermeiroAtual == -1)
                {
                    ClearFields();
                    MessageBox.Show("Não há mais enfermeiros!");
                }
                else
                {
                    textTotalEnfermeiros.Text = listBoxEnfermeiros.Items.Count.ToString();
                    idxEnfermeiroAtual = 0;
                    listBoxEnfermeiros.SelectedIndex = idxEnfermeiroAtual;
                    enfermeiroSelecionado = (Enfermeiro)listBoxEnfermeiros.Items[idxEnfermeiroAtual];
                    ShowEnfermeiro();
                }
            }
        }
    }
}
