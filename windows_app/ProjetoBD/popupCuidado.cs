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
    public partial class popupCuidado : Form
    {
        private SqlConnection cn;
        private Ligacao baseDados;

        private Utente utente;
        private UtentePage paginaUtente;
        private int idxCuidadoAtual;
        public popupCuidado(UtentePage utentePage, Utente utenteAtual)
        {
            baseDados = new Ligacao();

            InitializeComponent();
            paginaUtente = utentePage;
            utente = utenteAtual;
            setupCuidadosPopUp();
            Console.WriteLine("Utente recebido popup: " + utente.ToString());
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


        public void setupCuidadosPopUp()
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

        public void addCuidado()
        {
            if (!verifySGBDConnection())
                return;
            
            String cuidado = comboBoxCuidados.Items[idxCuidadoAtual].ToString();
            //String cuidado = comboBoxCuidados.GetItemText(idxCuidadoAtual);

            SqlCommand cmd = new SqlCommand("AddUtenteCuidado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@no_utente", Int32.Parse(utente.No_utente));
            Console.WriteLine("Cuidado antes do INSERT: " + cuidado);
            cmd.Parameters.AddWithValue("@tipo", cuidado);

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
                paginaUtente.setupCuidados();

                this.Dispose();
            }
        }
    }
}
