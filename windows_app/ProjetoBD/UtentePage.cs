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
    public partial class UtentePage : Form
    {

        private String dataNascAtual;
        private SqlConnection cn;
        private Ligacao baseDados;


        private Utente utente;
        private ListBox listaUtentes;
        private int utenteIndex;
        private Quarto quarto;
        private int idxQuartoAtual;
        private Quarto quartoSelecionado;
        private Casa casa;
        private Responsavel responsavel;
        private Apolice apolice;
        private int IdxCuidadoAtual;
        private ListBox listaDeCuidados;
        private List<Consulta> listaDeConsultas;
        private Consulta consultaAtual;

        public UtentePage(Utente utenteAtual)
        {
            baseDados = new Ligacao();
            InitializeComponent();
            LockEdits();
            utente = utenteAtual;
            ListaDeCuidados = listaCuidados;
            listaDeConsultas = new List<Consulta>();
            dateNascPicker.Hide();
            //dataNascAtual = textDataNasc.Text;
            //dateNascPicker.Value = DateTime.Parse(dataNascAtual); //dateNascPicker.Value.ToString("yyyy-MM-dd");
            setupUtenteData();
            setupQuartos();
            
            
        }

        public ListBox ListaUtentes { get => listaUtentes; set => listaUtentes = value; }
        public int UtenteIndex { get => utenteIndex; set => utenteIndex = value; }
        public ListBox ListaDeCuidados { get => listaDeCuidados; set => listaDeCuidados = value; }

        private SqlConnection getSGBDConnection()
        {
            return baseDados.getSGBDConnection(cn);
        }

        private bool verifySGBDConnection()
        {
            cn = getSGBDConnection();
            return baseDados.verifySGBDConnection(cn);
        }


        private void UpdateUtente()
        {

            if (!verifySGBDConnection())
            {
                Console.WriteLine("Ligação falhou no Update.");
                return;
            }

            Utente novoUtente = new Utente();
            try
            {
                
                novoUtente.Nome = tituloNome.Text;
                novoUtente.Cc_responsavel = textCCResp.Text;
                novoUtente.No_utente = textNo_utente.Text;
                novoUtente.Data_entrada = textDataEntrada.Text;
                novoUtente.Id_alojamento = textIDAloj.Text;
                novoUtente.Alcunha = textAlcunha.Text;
                novoUtente.Sexo = textSexo.Text;
                novoUtente.Data_nasc = textDataNasc.Text;

                novoUtente.Estado_civil = textEstadoCivil.Text;
                novoUtente.NIF = textNIF.Text;

                novoUtente.Subsistema_saude = textSubSaude.Text;
                novoUtente.Sns = textSNS.Text;
                novoUtente.Niss = textNISS.Text;
                novoUtente.Grau_dependencia = textGrauDep.Text;

                // caso tenha numero de telemovel, definir numero de telemovel
                if (textPhone.Text.Length > 5) 
                    novoUtente.Num_telemovel = textPhone.Text;

                // se tem quarto, fornecer definir morada anterior
                if (temQuarto(utente)) 
                    novoUtente.Morada_anterior = textMoradaAnterior.Text;
                


            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }

            int rows = 0;


            SqlCommand cmd = new SqlCommand("AlterUtente", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@no_utente", Convert.ToInt32(novoUtente.No_utente));
            cmd.Parameters.AddWithValue("@cc_resp", novoUtente.Cc_responsavel);
            cmd.Parameters.AddWithValue("@nome", novoUtente.Nome);
            //cmd.Parameters.AddWithValue("@fotografia", "null"); // nao vamos alterar a foto por argumento
            cmd.Parameters.AddWithValue("@alcunha", novoUtente.Alcunha);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(novoUtente.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", novoUtente.Sexo);
            cmd.Parameters.AddWithValue("@estado_civil", novoUtente.Estado_civil);
            cmd.Parameters.AddWithValue("@NIF", novoUtente.NIF);
            cmd.Parameters.AddWithValue("@data_entrada", DateTime.Parse(novoUtente.Data_entrada));
            cmd.Parameters.AddWithValue("@sns", novoUtente.Sns);
            cmd.Parameters.AddWithValue("@niss", novoUtente.Niss);
            cmd.Parameters.AddWithValue("@subsistema_saude", novoUtente.Subsistema_saude);
            cmd.Parameters.AddWithValue("@grau_dependencia", novoUtente.Grau_dependencia);

            if(textPhone.Text.Length > 5) // caso tenha numero de telemovel
            {
                cmd.Parameters.AddWithValue("@num_telemovel", novoUtente.Num_telemovel);
            }

            if (temQuarto(utente)) // se tem quarto, fornecer o número do quarto e a morada anterior
            {
                cmd.Parameters.AddWithValue("@morada_anterior", novoUtente.Morada_anterior);
                cmd.Parameters.AddWithValue("@numero", textNoQuarto_aloj.Text);
            }
            else if (!temQuarto(utente)) // se esta em casa, fornecer os dados da casa
            {
                cmd.Parameters.AddWithValue("@morada", textMoradaAtual.Text);
                cmd.Parameters.AddWithValue("@num_tel", textPhoneAloj.Text);
            }
            
            
            

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                
                rows = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Atualização do Utente falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                MessageBox.Show("Dados atualizados COM sucesso.");
                // atualizar a info do utente na lista
                utente = novoUtente;
                listaUtentes.Items[utenteIndex] = novoUtente;
                setupUtenteData();
                /*if (rows == 1)
                {
                    MessageBox.Show("Dados atualizados COM sucesso.");
                    // atualizar a info do utente na lista
                    utente = novoUtente;
                    listaUtentes.Items[utenteIndex] = novoUtente;
                    setupUtenteData();
                }

                else
                    MessageBox.Show("Dados atualizados SEM sucesso.");*/

                cn.Close();
            }
        }

        private void UpdateUtenteQuarto()
        {

            if (!verifySGBDConnection())
            {
                Console.WriteLine("Ligação falhou no Update.");
                return;
            }

            Utente novoUtente = new Utente();
            try
            {

                novoUtente.Nome = tituloNome.Text;
                novoUtente.Cc_responsavel = textCCResp.Text;
                novoUtente.No_utente = textNo_utente.Text;
                novoUtente.Data_entrada = textDataEntrada.Text;
                novoUtente.Id_alojamento = quartoSelecionado.Id.ToString(); // NOVO QUARTO
                Console.WriteLine("novoUtente.Id_alojamento -> " + novoUtente.Id_alojamento);
                novoUtente.Alcunha = textAlcunha.Text;
                novoUtente.Sexo = textSexo.Text;
                novoUtente.Data_nasc = textDataNasc.Text;

                novoUtente.Estado_civil = textEstadoCivil.Text;
                novoUtente.NIF = textNIF.Text;

                novoUtente.Subsistema_saude = textSubSaude.Text;
                novoUtente.Sns = textSNS.Text;
                novoUtente.Niss = textNISS.Text;
                novoUtente.Grau_dependencia = textGrauDep.Text;

                // caso tenha numero de telemovel, definir numero de telemovel
                if (textPhone.Text.Length > 5)
                    novoUtente.Num_telemovel = textPhone.Text;

                // como tem quarto, fornecer definir morada anterior
                novoUtente.Morada_anterior = textMoradaAnterior.Text;




            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }

            int rows = 0;


            SqlCommand cmd = new SqlCommand("AlterUtente", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@no_utente", Convert.ToInt32(novoUtente.No_utente));
            cmd.Parameters.AddWithValue("@cc_resp", novoUtente.Cc_responsavel);
            cmd.Parameters.AddWithValue("@nome", novoUtente.Nome);
            //cmd.Parameters.AddWithValue("@fotografia", "null"); // nao vamos alterar a foto por argumento
            cmd.Parameters.AddWithValue("@alcunha", novoUtente.Alcunha);
            cmd.Parameters.AddWithValue("@data_nasc", DateTime.Parse(novoUtente.Data_nasc));
            cmd.Parameters.AddWithValue("@sexo", novoUtente.Sexo);
            cmd.Parameters.AddWithValue("@estado_civil", novoUtente.Estado_civil);
            cmd.Parameters.AddWithValue("@NIF", novoUtente.NIF);
            cmd.Parameters.AddWithValue("@data_entrada", DateTime.Parse(novoUtente.Data_entrada));
            cmd.Parameters.AddWithValue("@sns", novoUtente.Sns);
            cmd.Parameters.AddWithValue("@niss", novoUtente.Niss);
            cmd.Parameters.AddWithValue("@subsistema_saude", novoUtente.Subsistema_saude);
            cmd.Parameters.AddWithValue("@grau_dependencia", novoUtente.Grau_dependencia);

            if (textPhone.Text.Length > 5) // caso tenha numero de telemovel
            {
                cmd.Parameters.AddWithValue("@num_telemovel", novoUtente.Num_telemovel);
            }

            // como tem quarto, fornecer dados de quem tem quarto
            cmd.Parameters.AddWithValue("@morada_anterior", novoUtente.Morada_anterior);
            cmd.Parameters.AddWithValue("@numero", quartoSelecionado.Numero);
            Console.WriteLine("FORNECER QUARTO NO Update");
            Console.WriteLine("quartoSelecionado.Numero -> " + quartoSelecionado.Numero);


            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();

                rows = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Atualização do Utente falhou. \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                MessageBox.Show("Dados atualizados COM sucesso.");
                // atualizar a info do utente na lista
                utente = novoUtente;
                quarto = quartoSelecionado;
                Console.WriteLine("quarto -> " + quarto.ToString());
                listaUtentes.Items[utenteIndex] = novoUtente;
                //setupUtenteData();
                Console.WriteLine(">> Depois da atribuição do novo quarto.");
                
                /*if (rows == 1)
                {
                    MessageBox.Show("Dados atualizados COM sucesso.");
                    // atualizar a info do utente na lista
                    utente = novoUtente;
                    listaUtentes.Items[utenteIndex] = novoUtente;
                    setupUtenteData();
                }

                else
                    MessageBox.Show("Dados atualizados SEM sucesso.");*/

                cn.Close();
            }
        }


        // --------------------------------------------------  SETUP ----------------------------------

        public void setupUtenteData()
        {
            Console.WriteLine(">> Entrei na setupUtenteData");
            if (!verifySGBDConnection())
            {
                Console.WriteLine("Nao ha ligacao.");
                return;
            }

            try
            {
                String caminho = "C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/idosos_cara/" + utente.No_utente + ".jpg";
                utenteFoto.Image = Image.FromFile(caminho);
            }
            catch (Exception)
            {
                try
                {
                    String caminhoPadrao = "C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/idosos_cara/placeholder.png";
                    utenteFoto.Image = Image.FromFile(caminhoPadrao);
                }
                catch (Exception)
                {
                    utenteFoto.Image = utenteFoto.ErrorImage;
                }
                
            }

            tituloNome.Text = utente.Nome;
            textNo_utente.Text = utente.No_utente;
            textDataEntrada.Text = utente.Data_entrada.Split(null)[0]; // tirar a hora

            // quarto ou casa
            if (temQuarto(utente))
            {
                Console.WriteLine("Tem quarto.");
                quarto = getQuarto(utente);
                casa = null;
                // dados do quarto e morada anterior
                labelNoQuarto.Show();
                textNoQuarto.Show();
                textNoQuarto.Text = quarto.Numero.ToString();
                labelMoradaAnterior.Show();
                textMoradaAnterior.Show();
                textMoradaAnterior.Text = utente.Morada_anterior;
                // esconder casa e morada atual
                labelMoradaAtual.Hide();
                textMoradaAtual.Hide();

                showQuarto();

            }

            else if (!temQuarto(utente))
            {
                Console.WriteLine("Nao tem quarto.");
                casa = getCasa(utente);
                quarto = null;
                // esconder dados do quarto e morada anterior
                labelNoQuarto.Hide();
                textNoQuarto.Hide();
                labelMoradaAnterior.Hide();
                textMoradaAnterior.Hide();
                // casa e morada atual
                labelMoradaAtual.Show();
                textMoradaAtual.Show();
                textMoradaAtual.Text = casa.Morada;

                showCasa();
            }

            textAlcunha.Text = utente.Alcunha;
            textSexo.Text = utente.Sexo;
            textDataNasc.Text = utente.Data_nasc.Split(null)[0]; dataNascAtual = textDataNasc.Text;

            textEstadoCivil.Text = utente.Estado_civil;
            textNIF.Text = utente.NIF;

            // numero telemovel
            if (utente.No_utente == "") textPhone.Text = "Nenhum";
            else textPhone.Text = utente.Num_telemovel;


            textSubSaude.Text = utente.Subsistema_saude;
            textSNS.Text = utente.Sns;
            textNISS.Text = utente.Niss;
            textGrauDep.Text = utente.Grau_dependencia;

            setupResponsavel();

            setupConsultas();

            setupApolice();

            setupCuidados();

            setupVisitas();

            Console.WriteLine("DATA NASC -> " + utente.Data_nasc);
            Console.WriteLine("DATA ENTRADA -> " + utente.Data_entrada);

            cn.Close();
        }

        public void setupConsultas()
        {
            if (!verifySGBDConnection())
                return;

            botaoDetalhesConsulta.Enabled = false;
            listaConsultas.ReadOnly = true;

            SqlCommand cmd = new SqlCommand("select * from GetConsultasUtente(@nUtente) order by ano desc", cn);
            cmd.Parameters.AddWithValue("@nUtente", utente.No_utente);
            SqlDataReader reader = cmd.ExecuteReader();
           

            while (reader.Read())
            {
                Consulta C = new Consulta();
                C.Numero = (int)reader["num_consulta"];
                C.Ano = (int)reader["ano"];
                C.NUtente = utente.No_utente;
                C.Data = reader["data"].ToString().Split(null)[0];
                C.NumMedico = (int)reader["num_id_medico"];
                C.NomeMedico = reader["nome_medico"].ToString();

                listaDeConsultas.Add(C);

                listaConsultas.Rows.Add(C.Numero.ToString(), C.Data, C.NomeMedico);
                

            }
            reader.Close();
            cn.Close();
        }

        public void setupVisitas()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from GetVisitas() where no_utente = " + utente.No_utente + " order by data desc";
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();


            while (reader.Read())
            {
                
                String visitante = reader["nome_visitante"].ToString();
                String ccVisitante = reader["cc_visitante"].ToString();
                String dataVisita = reader["data"].ToString().Split(null)[0];
                String horaEntrada = reader["hora_entrada"].ToString();
                String horaSaida = reader["hora_saida"].ToString();

                listaVisitas.Rows.Add(visitante, ccVisitante, dataVisita, horaEntrada, horaSaida);

            }
            reader.Close();
            cn.Close();
        }

        public void setupApolice()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("select * from getApolice(@nUtente)", cn);
            cmd.Parameters.AddWithValue("@nUtente", utente.No_utente);
            SqlDataReader reader = cmd.ExecuteReader();

            if (!reader.HasRows)
            {
                // inserir texto
                textApolice.Text = "";
                textPlano.Text = "";
                textSeguradora.Text = "";
                textTipo.Text = "";
                textPremio.Text = "";
                textModalidade.Text = "";
                textDataInicio.Text = "";
                textDataFim.Text = "";
                labelEuro.Text = "";
                logoApolice.Image = logoApolice.ErrorImage;
                cn.Close();
                return;
            }

            reader.Read();

            Apolice A = new Apolice();
            A.Numero = (int)reader["num"];
            A.Seguradora = reader["nome_seguradora"].ToString();
            A.Plano = reader["nome_plano"].ToString();
            A.NUtente = utente.No_utente;
            A.Preco = reader["preco"].ToString();
            A.Tipo = reader["tipo"].ToString();
            A.Data_inicio = reader["data_inicio"].ToString().Split(null)[0];
            A.Data_expiracao = reader["data_expiracao"].ToString().Split(null)[0];
            A.Modalidade_pagamento = reader["modalidade_pagamento"].ToString();

            apolice = A;

            reader.Close();

            // inserir texto
            textApolice.Text = A.Numero.ToString();
            textPlano.Text = A.Plano;
            textSeguradora.Text = A.Seguradora;
            textTipo.Text = A.Tipo;
            textPremio.Text = A.Preco;
            textModalidade.Text = A.Modalidade_pagamento;
            textDataInicio.Text = A.Data_inicio;
            textDataFim.Text = A.Data_expiracao;
            
            try
            {
                if (A.Plano.Contains("Confiança"))
                    logoApolice.Image = Image.FromFile("C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/seguro/confianca_saude.jpg");
                else if (A.Plano.Contains("Medi"))
                    logoApolice.Image = Image.FromFile("C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/seguro/medi_60.png");
                else if (A.Plano.Contains("Segura"))
                    logoApolice.Image = Image.FromFile("C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/seguro/segura_mais.png");
            }
            catch (Exception)
            {
                logoApolice.Image = logoApolice.ErrorImage;
            }

            
            setupDanos(apolice);




            cn.Close();
        }

        public void setupDanos(Apolice ap)
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("select * from GetDanosByApolice(@nApolice) order by descricao", cn);
            cmd.Parameters.AddWithValue("@nApolice", ap.Numero);
            SqlDataReader reader = cmd.ExecuteReader();
            listaDanos.Items.Clear();
            

            while (reader.Read())
            {
                String dano = reader["descricao"].ToString();
                ap.Danos.Add(dano);
                listaDanos.Items.Add(dano);

            }
            reader.Close();
            cn.Close();
        }

        public void setupCuidados()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand("select * from getCuidadosUtente(@no_utente) order by tipo", cn);
            cmd.Parameters.AddWithValue("@no_utente", utente.No_utente);
            SqlDataReader reader = cmd.ExecuteReader();
            listaCuidados.Items.Clear();


            while (reader.Read())
            {
                String cuidado = reader["tipo"].ToString();
                listaCuidados.Items.Add(cuidado);

            }
            reader.Close();
            cn.Close();
        }
        public bool temQuarto(Utente utente)
        {
            if (!verifySGBDConnection())
            {
                Console.WriteLine("Nao ha ligacao.");
                return false;
            }


            SqlCommand cmd = new SqlCommand("select dbo.CheckQuarto(@utente_no)", cn);
            cmd.Parameters.AddWithValue("@utente_no", utente.No_utente);
            Console.WriteLine("Comando SQL temQuarto: " + cmd.CommandText);

            var result = cmd.ExecuteScalar();
            int q = (int)result;

            Console.WriteLine("Quarto -> " + q);

            if (q > 0)
            {
                cn.Close();
                return true;
            }

         
            cn.Close();
            return false;
        }

        public Quarto getQuarto(Utente utente)
        {
            if (!verifySGBDConnection())
            {
                Console.WriteLine("Nao ha ligacao.");
                return null;
            }

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from getUtenteQuarto(@no_utente)";
            cmd.Parameters.AddWithValue("@no_utente", utente.No_utente);
            Console.WriteLine("Comando SQL getQuarto: " + cmd.CommandText);
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();
            reader.Read();

            Quarto Q = new Quarto();
            Q.Id = (int)reader["id"];
            Q.Numero = (int)reader["numero"];
            Q.Detalhes = reader["detalhes"].ToString();

            Console.WriteLine("Quarto no getQuarto -> " + Q.ToString());

            reader.Close();
            cn.Close();

            return Q;

        }

        public Casa getCasa(Utente utente)
        {
            if (!verifySGBDConnection())
            {
                Console.WriteLine("Nao ha ligacao.");
                return null;
            }

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from getUtenteCasa(@no_utente)";
            cmd.Parameters.AddWithValue("@no_utente", utente.No_utente);
            Console.WriteLine("Comando SQL getCasa: " + cmd.CommandText);
            cmd.Connection = cn;

            SqlDataReader reader = cmd.ExecuteReader();
            reader.Read();

            Casa C = new Casa();
            C.Id = (int)reader["id"];
            C.Morada = reader["morada"].ToString();
            C.Telefone = reader["numero_telefone"].ToString();

            reader.Close();
            cn.Close();

            return C;

        }
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

        public void setupResponsavel()
        {
            if (!verifySGBDConnection())
                return;


            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from GetUtenteResponsavel(@no_utente)";
            cmd.Parameters.AddWithValue("@no_utente", utente.No_utente);
            cmd.Connection = cn;
            SqlDataReader reader = cmd.ExecuteReader();

            Console.WriteLine("Comando Resp: " + cmd.CommandText);

            reader.Read();

            Responsavel R = new Responsavel();
            R.Cc = reader["cartao_cidadao"].ToString();
            R.Nome = reader["Rnome"].ToString();
            R.Morada = reader["morada"].ToString();
            R.Tipo = reader["tipo"].ToString();
            R.Telemovel = reader["numero_telefone"].ToString();

            textNomeResp.Text = R.Nome;
            textCCResp.Text = R.Cc;
            textMoradaResp.Text = R.Morada;
            textTipoResp.Text = R.Tipo;
            textPhoneResp.Text = R.Telemovel;

            responsavel = R;

            try
            {
                String caminhoPadrao = "C:/Users/alxlo/source/repos/ProjetoBD/ProjetoBD/idosos_cara/placeholder.png";
                respFoto.Image = Image.FromFile(caminhoPadrao);
            }
            catch (Exception)
            {
                respFoto.Image = respFoto.ErrorImage;
            }

            reader.Close();
            cn.Close();
        }

        public void showQuarto()
        {
            textIDAloj.Text = quarto.Id.ToString();
            labelNoQuarto_aloj.Show();
            textNoQuarto_aloj.Show();
            textNoQuarto_aloj.Text = quarto.Numero.ToString();

            labelMoradaAloj.Hide();
            textMoradaAloj.Hide();
            labelPhoneAloj.Hide();
            textPhoneAloj.Hide();

            linha_aloj.Show();
            labelDetalhesAloj.Show();
            textDetalhesAloj.Show();
            textDetalhesAloj.Text = quarto.Detalhes;

            comboBoxQuartos.Hide();
            botaoMudarQuarto.Show();
            botaoGuardarQuarto.Hide();
            botaoCancelarAlterQuarto.Hide();



        }

        public void showCasa()
        {
            textIDAloj.Text = casa.Id.ToString();

            labelNoQuarto_aloj.Hide();
            textNoQuarto_aloj.Hide();

            labelMoradaAloj.Show();
            textMoradaAloj.Show();
            textMoradaAloj.Text = casa.Morada;
            labelPhoneAloj.Show();
            textPhoneAloj.Show();
            textPhoneAloj.Text = casa.Telefone.ToString();

            linha_aloj.Hide();
            labelDetalhesAloj.Hide();
            textDetalhesAloj.Hide();

            botaoMudarQuarto.Hide();
            botaoGuardarQuarto.Hide();
            botaoCancelarAlterQuarto.Hide();
            comboBoxQuartos.Hide();

        }

        // ---------------------------------------------------------------------------------------------

  





        // --------------------------------------------------  BOTOES ----------------------------------

        private void voltarClick(object sender, EventArgs e)
        {
            ListaUtentes utentes = new ListaUtentes();
            utentes.ListaAllUtentes = listaUtentes;
            utentes.Show();
            this.Hide();
            Console.WriteLine("Utente atual (voltar): " + this.utente.Nome);
        }

        private void BotaoMudarQuarto_Click(object sender, EventArgs e)
        {
            comboBoxQuartos.Show();     
            botaoGuardarQuarto.Show();
            botaoCancelarAlterQuarto.Show();
            botaoMudarQuarto.Hide();
            
        }
        private void BotaoGuardarQuarto_Click(object sender, EventArgs e)
        {
            comboBoxQuartos.Hide();
            botaoMudarQuarto.Show();
            botaoGuardarQuarto.Hide();
            botaoCancelarAlterQuarto.Hide();
            UpdateUtenteQuarto();
            //quarto = quartoSelecionado;
            Console.WriteLine("Depois do UPDATE QUARTO.");
            Console.WriteLine("QUARTO Depois do UPDATE -> " + quarto.ToString());  
            setupUtenteData(); // showQuarto(); é chamada aqui
            //showQuarto();
        }

        private void BotaoCancelarAlterQuarto_Click(object sender, EventArgs e)
        {
            comboBoxQuartos.Hide();
            botaoMudarQuarto.Show();
            botaoGuardarQuarto.Hide();
            botaoCancelarAlterQuarto.Hide();
        }
        private void atualizarClick(object sender, EventArgs e)
        {
            atualizarButton.Hide();
            guardar_button.Show();
            EnableEdits();
        }

        private void guardar_click(object sender, EventArgs e)
        {
            guardar_button.Hide();
            atualizarButton.Show();
            LockEdits();
            UpdateUtente();
        }

        private void ButtonRemoveCuidado_Click(object sender, EventArgs e)
        {
            if (listaCuidados.SelectedIndex > -1)
            {
                try
                {
                    RemoverCuidado(IdxCuidadoAtual);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                listaCuidados.Items.RemoveAt(listaCuidados.SelectedIndex);
                if (IdxCuidadoAtual == listaCuidados.Items.Count)
                    IdxCuidadoAtual = listaCuidados.Items.Count - 1;
                if (IdxCuidadoAtual == -1)
                {
                    MessageBox.Show("Não há mais cuidados neste utente.");
                }
                else
                {
                    setupCuidados();
                }
            }
        }

        public void RemoverCuidado(int cuidadoIndex)
        {
            if (!verifySGBDConnection())
                return;


            String cuidado = listaCuidados.Items[cuidadoIndex].ToString();

            SqlCommand cmd = new SqlCommand("RemoveUtenteCuidado", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@no_utente", utente.No_utente);
            cmd.Parameters.AddWithValue("@tipo", cuidado);

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

        private void ButtonAddCuidadoUtente_Click(object sender, EventArgs e)
        {
            popupCuidado popUp = new popupCuidado(this, utente);
            popUp.ShowDialog();
            Console.WriteLine("Utente atual (popup): " + utente.ToString());
        }

        private void BotaoDetalhesConsulta_Click(object sender, EventArgs e)
        {
            int p = getPrescricao(consultaAtual.Numero);
            detalhesConsultaPopup popUpConsulta = new detalhesConsultaPopup(consultaAtual, p);
            popUpConsulta.ShowDialog();
            Console.WriteLine("Consulta atual (popup): " + utente.ToString());
        }

        public void LockEdits()
        {
            textAlcunha.ReadOnly = true;
            textEstadoCivil.ReadOnly = true;
            textPhone.ReadOnly = true;
            textSubSaude.ReadOnly = true;
            textGrauDep.ReadOnly = true;

            //textDataNasc.Show();
            //dateNascPicker.Hide();
            //dataNascAtual = dateNascPicker.Value.ToString("yyyy-MM-dd").Split(null)[0];
            //textDataNasc.Text = dataNascAtual.Split(null)[0];
        }

        public void EnableEdits()
        {
            textAlcunha.ReadOnly = false;
            textEstadoCivil.ReadOnly = false;
            textPhone.ReadOnly = false;
            textSubSaude.ReadOnly = false;
            textGrauDep.ReadOnly = false;

            //textDataNasc.Hide();
            //dateNascPicker.Show();

        }

        // ---------------------------------------------------------------------------------------------



        // --------------------------------------------------------   OUTRAS   -----------------------------------------------------------------------


        private void ListaCuidados_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listaCuidados.SelectedIndex >= 0)
            {
                IdxCuidadoAtual = listaCuidados.SelectedIndex;
                Console.WriteLine("Cuidado atual: " + IdxCuidadoAtual);
            }
        }

        private void ComboBoxQuartos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxQuartos.SelectedIndex >= 0)
            {
                idxQuartoAtual = comboBoxQuartos.SelectedIndex;
                quartoSelecionado = (Quarto)comboBoxQuartos.Items[idxQuartoAtual];
                Console.WriteLine("Quarto selecionado: " + quartoSelecionado.ToString() + " | idx: " + idxQuartoAtual);
            }
        }
        private void DataGridView1_CellContentClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (listaConsultas.SelectedCells.Count > 0)
            {
                int selectedrowindex = listaConsultas.SelectedCells[0].RowIndex;

                DataGridViewRow selectedRow = listaConsultas.Rows[selectedrowindex];

                int n = Convert.ToInt32(selectedRow.Cells["no_consulta"].Value);
                Console.WriteLine("Numero Consulta selecionada: " + n);

                for (int i = 0; i < listaDeConsultas.Count(); i++)
                {
                    Consulta c = listaDeConsultas.ElementAt(i);
                    if (c.Numero == n)
                    {
                        consultaAtual = c;
                        break;
                    }
                }

                if (hasPrescricao(consultaAtual))
                    botaoDetalhesConsulta.Enabled = true;
                else botaoDetalhesConsulta.Enabled = false;

                Console.WriteLine("Consulta selecionada: " + consultaAtual);

                //string a = Convert.ToString(selectedRow.Cells["you have to mention you cell  corresponding column name"].Value);
            }
        }

        private int getPrescricao(int c)
        {
            if (!verifySGBDConnection())
                return -1;


            SqlCommand cmd = new SqlCommand("select dbo.getPrescricaoConsulta(@no_consulta, @ano)", cn);
            cmd.Parameters.AddWithValue("@no_consulta", consultaAtual.Numero);
            cmd.Parameters.AddWithValue("@ano", consultaAtual.Ano);
            cmd.CommandType = CommandType.Text;


            var result = cmd.ExecuteScalar();

            int n = (int)result;

            Console.WriteLine("Numero Prescricao: " + n);

            cn.Close();

            return n;
        }

        private bool hasPrescricao(Consulta c)
        {
            if (!verifySGBDConnection())
                return false;

            int n;
            SqlCommand cmd = new SqlCommand("select dbo.ConsultaHasPrescricao(@no_consulta, @ano)", cn);
            cmd.Parameters.AddWithValue("@no_consulta", c.Numero);
            cmd.Parameters.AddWithValue("@ano", c.Ano);

            var result = cmd.ExecuteScalar();

            n = (int)result;

            Console.WriteLine("N -> " + n);
            cn.Close();

            if (n == 1)
                return true;
            else return false;

        }

        private void UtentePage_FormClosing(object sender, FormClosingEventArgs e)
        {
            ListaUtentes utentes = new ListaUtentes();
            utentes.ListaAllUtentes = listaUtentes;
            utentes.Show();
            this.Hide();
            Console.WriteLine("Utente atual (fechar): " + this.utente.Nome);
        }

        // ---------------------------------------------------------------------------------------------






















        // --------------------------------------------------------   LIXO   -----------------------------------------------------------------------
        private void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void Label2_Click(object sender, EventArgs e)
        {

        }

        private void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void Label1_Click(object sender, EventArgs e)
        {

        }

        private void Label1_Click_1(object sender, EventArgs e)
        {

        }
        private void Label3_Click(object sender, EventArgs e)
        {

        }

        private void Label6_Click(object sender, EventArgs e)
        {

        }

        private void Label7_Click(object sender, EventArgs e)
        {

        }

        private void Label19_Click(object sender, EventArgs e)
        {

        }

        private void Label24_Click(object sender, EventArgs e)
        {

        }

        private void Label17_Click(object sender, EventArgs e)
        {

        }

        private void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void PictureBox2_Click(object sender, EventArgs e)
        {

        }












        /*
        private void Datagridview1_SelectionChanged(object sender, EventArgs e)
        {
            if (listaConsultas.SelectedCells.Count > 0)
            {
                int selectedrowindex = listaConsultas.SelectedCells[0].RowIndex;

                DataGridViewRow selectedRow = listaConsultas.Rows[selectedrowindex];

                int n = Convert.ToInt32(selectedRow.Cells["no_consulta"].Value);
                Console.WriteLine("Numero Consulta selecionada: " + n);

                for (int i = 0; i < listaDeConsultas.Count(); i++)
                {
                    Consulta c = listaDeConsultas.ElementAt(i);
                    if (c.Numero == n)
                    {
                        consultaAtual = c;
                        break;
                    }
                }

                Console.WriteLine("Consulta selecionada: " + consultaAtual);

                //string a = Convert.ToString(selectedRow.Cells["you have to mention you cell  corresponding column name"].Value);
            }
        }
        */





    }
}
