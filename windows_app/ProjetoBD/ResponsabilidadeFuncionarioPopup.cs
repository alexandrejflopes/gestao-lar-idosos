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
    public partial class ResponsabilidadeFuncionarioPopup : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;


        private Funcionario funcionario;
        private Funcionarios paginaFuncionario;
        private int idxCuidadoAtual;

        public ResponsabilidadeFuncionarioPopup(Funcionarios fPage, Funcionario f)
        {
            baseDados = new Ligacao();

            InitializeComponent();
            paginaFuncionario = fPage;
            funcionario = f;
            textID.Text = f.Id.ToString();
            setupAllCuidadosPopUp();
            setupCuidadosFuncionario();
            lockAddCuidado();
            Console.WriteLine("Funcionario recebido popup: " + funcionario.ToString());
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


        public void addCuidado()
        {
            if (!verifySGBDConnection())
                return;

            String cuidado = comboBoxCuidados.Items[idxCuidadoAtual].ToString();
            //String cuidado = comboBoxCuidados.GetItemText(idxCuidadoAtual);

            SqlCommand cmd = new SqlCommand("AddCuidadoPrestado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@num_emp", funcionario.Id);
            cmd.Parameters.AddWithValue("@tipo_cuidado", cuidado);
            Console.WriteLine("Antes do INSERT: " + funcionario.ToString() + " >> " + cuidado);

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Adição do cuidado falhou. \n ERRO: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }


        public void RemoverCuidado(int cuidadoIndex)
        {
            if (!verifySGBDConnection())
                return;


            String cuidado = listaCuidados.Items[cuidadoIndex].ToString();

            SqlCommand cmd = new SqlCommand("RemoveCuidadoPrestado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@num_emp", funcionario.Id);
            cmd.Parameters.AddWithValue("@tipo_cuidado", cuidado);

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Remoção do Cuidado falhou. \n ERRO: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }
        public void allowAddCuidado()
        {
            buttonRemoveCuidado.Hide();
            buttonAddCuidadoFuncionario.Hide();
            panelAddCuidado.Show();
            buttonCancelarAddCuidado.Show();
        }

        public void lockAddCuidado()
        {
            buttonRemoveCuidado.Show();
            buttonAddCuidadoFuncionario.Show();
            panelAddCuidado.Hide();
            buttonCancelarAddCuidado.Hide();
        }

        public void setupCuidadosFuncionario()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("select * from GetCuidadosFuncionario(@num_id)", cn);
            cmd.Parameters.AddWithValue("@num_id", funcionario.Id);
            SqlDataReader reader = cmd.ExecuteReader();
            listaCuidados.Items.Clear();

            while (reader.Read())
            {
                String cuidado = reader["tipo_cuidado"].ToString();
                listaCuidados.Items.Add(cuidado);

            }
            reader.Close();
            cn.Close();

        }

        public void setupAllCuidadosPopUp()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("select * from getCuidados()", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            comboBoxCuidados.Items.Clear();

            while (reader.Read())
            {
                String cuidado = reader["tipo"].ToString();
                comboBoxCuidados.Items.Add(cuidado);

            }
            reader.Close();
            cn.Close();

        }
        private void ComboBoxCuidados_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxCuidados.SelectedIndex >= 0)
            {
                idxCuidadoAtual = comboBoxCuidados.SelectedIndex;
                Console.WriteLine("Cuidado atual popup: " + comboBoxCuidados.GetItemText(idxCuidadoAtual));
            }
        }

        private void ConfirmarButton_Click(object sender, EventArgs e)
        {
            if (comboBoxCuidados.SelectedIndex > -1)
            {
                try
                {
                    addCuidado();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                setupCuidadosFuncionario();

                lockAddCuidado();

            }
        }

        private void BotaoSair_Click(object sender, EventArgs e)
        {
            this.Dispose();
        }

        private void ButtonAddCuidadoFuncionario_Click(object sender, EventArgs e)
        {
            allowAddCuidado();
        }

        private void ButtonRemoveCuidado_Click(object sender, EventArgs e)
        {
            if (listaCuidados.SelectedIndex > -1)
            {
                try
                {
                    RemoverCuidado(idxCuidadoAtual);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                listaCuidados.Items.RemoveAt(listaCuidados.SelectedIndex);
                if (idxCuidadoAtual == listaCuidados.Items.Count)
                    idxCuidadoAtual = listaCuidados.Items.Count - 1;
                if (idxCuidadoAtual == -1)
                {
                    MessageBox.Show("Não há mais responsabilidade neste funcionário.");
                }
                else
                {
                    setupCuidadosFuncionario();
                }
            }
        }

        private void ListaCuidados_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listaCuidados.SelectedIndex >= 0)
            {
                idxCuidadoAtual = listaCuidados.SelectedIndex;
                Console.WriteLine("Cuidado atual: " + idxCuidadoAtual);
            }
        }

        private void ComboBoxCuidados_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (comboBoxCuidados.SelectedIndex >= 0)
            {
                idxCuidadoAtual = comboBoxCuidados.SelectedIndex;
                Console.WriteLine("Cuidado atual popup: " + comboBoxCuidados.GetItemText(idxCuidadoAtual));
            }
        }

        private void ButtonCancelarAddCuidado_Click(object sender, EventArgs e)
        {
            lockAddCuidado();
        }

        private void LabelDetalhesAloj_Click(object sender, EventArgs e)
        {

        }
    }
}
