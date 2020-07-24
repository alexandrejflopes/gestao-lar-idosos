using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Apolice
    {
        private int numero;
        private String seguradora;
        private String plano;
        private String nUtente;
        private String preco;
        private String tipo;
        private String data_inicio;
        private String data_expiracao;
        private String modalidade_pagamento;
        private List<String> danos;

        public Apolice() { danos = new List<string>(); }

        public int Numero { get => numero; set => numero = value; }
        public string Seguradora { get => seguradora; set => seguradora = value; }
        public string Plano { get => plano; set => plano = value; }
        public String NUtente { get => nUtente; set => nUtente = value; }
        public String Preco { get => preco; set => preco = value; }
        public string Data_inicio { get => data_inicio; set => data_inicio = value; }
        public string Data_expiracao { get => data_expiracao; set => data_expiracao = value; }
        public string Modalidade_pagamento { get => modalidade_pagamento; set => modalidade_pagamento = value; }
        public List<string> Danos { get => danos; set => danos = value; }
        public string Tipo { get => tipo; set => tipo = value; }
    }
}
