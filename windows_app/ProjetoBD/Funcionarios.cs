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
    public partial class Funcionarios : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;

        private int idxFuncAtual;
        private Funcionario funcSelecionado;
        public Funcionarios()
        {
            baseDados = new Ligacao();
            InitializeComponent();
            loadFuncionariosOnStart();
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
        }

        public void AllowEdits()
        {
            botaoEditFuncionario.Hide();
            botaoEliminarFuncionario.Hide();
            buttonAddCuidado.Hide();
            botaoGuardar.Show();
            botaoCancelar.Show();
            textNome.Enabled = false;
            textNIF.Enabled = false;
            textNasc.Enabled = false;
            textSexo.Enabled = false;
            textPhone.Enabled = true;
            textPhone.ReadOnly = false;
            listBoxFuncionarios.Enabled = false;
        }

        public void LockEdits()
        {
            botaoEditFuncionario.Show();
            botaoEliminarFuncionario.Show();
            buttonAddCuidado.Show();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            textNome.Enabled = false;
            textNIF.Enabled = false;
            textNasc.Enabled = false;
            textSexo.Enabled = false;
            textPhone.Enabled = false;
            listBoxFuncionarios.Enabled = true;
        }


        public void AllowAddEdits()
        {
            
            botaoEditFuncionario.Hide();
            botaoEliminarFuncionario.Hide();
            buttonAddCuidado.Hide();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            botaoGuardarAdd.Show();
            botaoCancelarAdd.Show();
            labelNoFuncionario.Hide();
            textID.Hide();
            labelNovoFunc.Show();
            textNome.Enabled = true;
            textNome.ReadOnly = false;
            textNIF.Enabled = true;
            textNIF.ReadOnly = false;
            dateTimePicker1.Show();
            textNasc.Hide();
            comboBoxSexo.Show();
            textSexo.Hide();
            textPhone.Enabled = true;
            textPhone.ReadOnly = false;
            listBoxFuncionarios.Enabled = false;
        }

        public void LockAddEdits()
        {
            labelNoFuncionario.Show();
            textID.Show();
            labelNovoFunc.Hide();

            botaoEditFuncionario.Show();
            botaoEliminarFuncionario.Show();
            buttonAddCuidado.Show();
            botaoGuardar.Hide();
            botaoCancelar.Hide();
            botaoGuardarAdd.Hide();
            botaoCancelarAdd.Hide();

            textNome.Enabled = false; 
            textNIF.Enabled = false;

            dateTimePicker1.Hide();
            textNasc.Show();
            textNasc.Enabled = false;

            comboBoxSexo.Hide();
            textSexo.Show();
            textSexo.Enabled = false;

            textPhone.Enabled = false;

            listBoxFuncionarios.Enabled = true;
            
        }

        public void loadFuncionariosOnStart()
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


            SqlCommand cmd = new SqlCommand("SELECT * from GetFuncionarios() order by num_id", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBoxFuncionarios.Items.Clear();

            while (reader.Read())
            {
                Funcionario F = new Funcionario();
                F.Id = (int)reader["num_id"];
                F.Nome = reader["nome"].ToString();
                F.Nif = reader["nif"].ToString();
                F.Data_nasc = reader["data_nasc"].ToString().Split(null)[0];
                F.Sexo = reader["sexo"].ToString();
                F.Telefone = reader["num_telefone"].ToString();


                listBoxFuncionarios.Items.Add(F);

            }

            textTotalFuncionarios.Text = listBoxFuncionarios.Items.Count.ToString();

            cn.Close();

            // primeiro funcionario da lista
            idxFuncAtual = 0; 
            funcSelecionado = (Funcionario)listBoxFuncionarios.Items[idxFuncAtual];
            LockEdits();
            LockAddEdits();
            ShowFuncionario();
        }



        private void UpdateFuncionario(Funcionario func)
        {
            int rows = 0;

            Console.WriteLine("Entrei no update -> " + func.Id + " | " + func.Nome + " | " + func.Nif + " | " + func.Data_nasc + " | " + func.Sexo + " | " + func.Telefone);

            if (!verifySGBDConnection())
                return;

            Console.WriteLine("Conexão -> " + cn.State);

            SqlCommand cmd = new SqlCommand("AlterFuncionario", cn);
            Console.WriteLine("Passei na conexao");
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Clear();

            Console.WriteLine("FUNCIONARIO\n" + func.Id + " | " + func.Nome + " | " + func.Nif + " | " + func.Data_nasc + " | " + func.Sexo + " | " + func.Telefone);

            cmd.Parameters.AddWithValue("@num_id", func.Id);
            cmd.Parameters.AddWithValue("@nome", func.Nome);
            cmd.Parameters.AddWithValue("@nif", func.Nif);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(func.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", func.Sexo);
            cmd.Parameters.AddWithValue("@num_telefone", func.Telefone);

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
                if (rows == 5 || rows == 6) // com ou sem foto
                    MessageBox.Show("Dados atualizados com sucesso.");
                else
                    MessageBox.Show("Dados atualizados sem sucesso.");

                cn.Close();
            }
        }

        private void SubmitFuncionario(Funcionario func)
        {
            int rows = 0;
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("AddFuncionario", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Clear();

            cmd.Parameters.Clear();
            //cmd.Parameters.AddWithValue("@num_id", func.Id);
            cmd.Parameters.AddWithValue("@nome", func.Nome);
            cmd.Parameters.AddWithValue("@nif", func.Nif);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(func.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", func.Sexo);
            cmd.Parameters.AddWithValue("@num_telefone", func.Telefone);
            //cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Registo de funcionário falhou. \n ERROR MESSAGE: \n" + ex.Message);
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


        private bool SaveNovoFuncionario()
        {
            Funcionario novoFuncionario = new Funcionario();
            try
            {
                //novoFuncionario.Id = 202;//Convert.ToInt32(textID.Text);
                novoFuncionario.Nome = textNome.Text;
                novoFuncionario.Nif = textNIF.Text;
                novoFuncionario.Sexo = comboBoxSexo.Items[comboBoxSexo.SelectedIndex].ToString();
                novoFuncionario.Data_nasc = dateTimePicker1.Value.ToString("yyyy-MM-dd");
                novoFuncionario.Telefone = textPhone.Text;

            }

            catch (Exception ex)
            {
                MessageBox.Show("Save NOVO Funcionario -> " + ex.Message);
                return false;
            }

            Console.WriteLine("novoAddFuncionario -> " + novoFuncionario.Id + " | " + novoFuncionario.Nome + " | " + novoFuncionario.Nif + " | " + novoFuncionario.Data_nasc + " | " + novoFuncionario.Sexo + " | " + novoFuncionario.Telefone);

            SubmitFuncionario(novoFuncionario);

            Console.WriteLine("Depois do Update Funcionario");

            listBoxFuncionarios.Items.Add(novoFuncionario);
            loadFuncionariosOnStart();
            return true;
        }


        private bool SaveFuncionario()
        {
            Funcionario novoFuncionario = new Funcionario();
            try
            {
                novoFuncionario.Id = Convert.ToInt32(textID.Text);
                novoFuncionario.Nome = textNome.Text;
                novoFuncionario.Nif = textNIF.Text;
                novoFuncionario.Sexo = textSexo.Text;
                novoFuncionario.Data_nasc = textNasc.Text;
                novoFuncionario.Telefone = textPhone.Text;

            }

            catch (Exception ex)
            {
                MessageBox.Show("Save Funcionario -> " + ex.Message);
                return false;
            }

            Console.WriteLine("novoFuncionario -> " + novoFuncionario.Id + " | " + novoFuncionario.Nome + " | " + novoFuncionario.Nif + " | " + novoFuncionario.Data_nasc + " | " + novoFuncionario.Sexo + " | " + novoFuncionario.Telefone);

            UpdateFuncionario(novoFuncionario);

            Console.WriteLine("Depois do Update Funcionario");

            listBoxFuncionarios.Items[idxFuncAtual] = novoFuncionario;
            return true;
        }



        private void RemoveFuncionario(Funcionario func)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("RemoveEmpregado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@num_id", Convert.ToInt32(func.Id));

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Remoção do funcionário falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }


        public void ShowFuncionario()
        {
            if (listBoxFuncionarios.Items.Count == 0 | idxFuncAtual < 0)
                return;

            textID.Text = funcSelecionado.Id.ToString();
            textNome.Text = funcSelecionado.Nome;
            textNIF.Text = funcSelecionado.Nif;
            textNasc.Text = funcSelecionado.Data_nasc.Split(null)[0];
            textSexo.Text = funcSelecionado.Sexo;
            textPhone.Text = funcSelecionado.Telefone;

        }





        // -------------------------------------------------- BOTOES --------------------------------------------------

        private void ListBoxFuncionarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBoxFuncionarios.SelectedIndex >= 0)
            {
                idxFuncAtual = listBoxFuncionarios.SelectedIndex;
                funcSelecionado = (Funcionario)listBoxFuncionarios.Items[idxFuncAtual];
                ShowFuncionario();
                Console.WriteLine("Funcionario atual: " + funcSelecionado.ToString());
            }
        }

        private void BotaoEditFuncionario_Click(object sender, EventArgs e)
        {
            
            if (idxFuncAtual < 0)
            {
                MessageBox.Show("Selecione um funcionário para editar.");
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
                SaveFuncionario();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Logo ao Clicar -> " + ex.Message);
            }

            //SaveFuncionario();
            listBoxFuncionarios.Enabled = true;
            int idx = listBoxFuncionarios.FindString(textID.Text);
            Console.WriteLine("idx -> " + idx);
            listBoxFuncionarios.SelectedIndex = idx;
            LockEdits();
        }

        private void BotaoGuardarAdd_Click(object sender, EventArgs e)
        {
            try
            {
                Console.WriteLine("Entrei no TRY ADD");
                SaveNovoFuncionario();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Logo ao Clicar ADD -> " + ex.Message);
            }

            //SaveFuncionario();
            listBoxFuncionarios.Enabled = true;
            int idx = listBoxFuncionarios.FindString(textID.Text);
            Console.WriteLine("idx -> " + idx);
            listBoxFuncionarios.SelectedIndex = idx;
            textTotalFuncionarios.Text = listBoxFuncionarios.Items.Count.ToString();
            LockAddEdits();
        }
        private void BotaoCancelarAdd_Click(object sender, EventArgs e)
        {
            if (listBoxFuncionarios.Items.Count > 0)
            {
                idxFuncAtual = listBoxFuncionarios.SelectedIndex;
                if (idxFuncAtual < 0)
                    idxFuncAtual = 0;

                funcSelecionado = (Funcionario)listBoxFuncionarios.Items[idxFuncAtual];
                ShowFuncionario();
            }
            LockAddEdits();
        }
        private void ButtonAddFuncionario_Click(object sender, EventArgs e)
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

        private void Funcionarios_FormClosing(object sender, FormClosingEventArgs e)

        {
            PaginaInicial home = new PaginaInicial();
            home.Show();
            this.Hide();

        }



        // -------------------------------------------------- LIXO --------------------------------------------------
        private void Label19_Click(object sender, EventArgs e)
        {

        }

        private void BotaoEliminarFuncionario_Click(object sender, EventArgs e)
        {
            if (listBoxFuncionarios.SelectedIndex > -1)
            {
                try
                {
                    RemoveFuncionario(funcSelecionado);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                listBoxFuncionarios.Items.RemoveAt(listBoxFuncionarios.SelectedIndex);
                if (idxFuncAtual == listBoxFuncionarios.Items.Count)
                    idxFuncAtual = listBoxFuncionarios.Items.Count - 1;
                if (idxFuncAtual == -1)
                {
                    ClearFields();
                    MessageBox.Show("Não há mais funcionários!");
                }
                else
                {
                    textTotalFuncionarios.Text = listBoxFuncionarios.Items.Count.ToString();
                    idxFuncAtual = 0;
                    listBoxFuncionarios.SelectedIndex = idxFuncAtual;
                    funcSelecionado = (Funcionario)listBoxFuncionarios.Items[idxFuncAtual];
                    
                    ShowFuncionario();
                }
            }
        }

        private void ButtonAddCuidado_Click(object sender, EventArgs e)
        {
            ResponsabilidadeFuncionarioPopup popUp = new ResponsabilidadeFuncionarioPopup(this, funcSelecionado);
            popUp.ShowDialog();
            Console.WriteLine("Func atual (popup): " + funcSelecionado.ToString());
        }
    }
}
