using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    
    public class Funcionario
    {
        private int id;
        private String nome;
        private String nif;
        private String data_nasc;
        private String sexo;
        private String telefone;

        public Funcionario() { }

        public int Id { get => id; set => id = value; }
        public string Nome { get => nome; set => nome = value; }
        public string Nif { get => nif; set => nif = value; }
        public string Data_nasc { get => data_nasc; set => data_nasc = value; }
        public string Sexo { get => sexo; set => sexo = value; }
        public string Telefone { get => telefone; set => telefone = value; }

        public override String ToString()
        {
            return Id + " | " + Nome;
        }
    }
}
