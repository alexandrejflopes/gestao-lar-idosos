using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ProjetoBD
{
    public partial class PaginaInicial : Form
    {
        public PaginaInicial()
        {
            InitializeComponent();
        }

        private void PictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void BotaoUtentes_Click(object sender, EventArgs e)
        {
            ListaUtentes listagemUtentes = new ListaUtentes();
            listagemUtentes.Show();
            this.Hide();
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void BotaoFuncionarios_Click(object sender, EventArgs e)
        {
            Funcionarios listagemFuncionarios = new Funcionarios();
            listagemFuncionarios.Show();
            this.Hide();
        }

        private void PaginaInicial_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void BotaoEnfermeiros_Click(object sender, EventArgs e)
        {
            Enfermeiros listagemEnfermeiros = new Enfermeiros();
            listagemEnfermeiros.Show();
            this.Hide();
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            Visitas listagemVisitas = new Visitas();
            listagemVisitas.Show();
            this.Hide();
        }
    }
}
