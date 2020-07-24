using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Visitante
    {
        private String cartao_cidadao;
        private String nome;

     

        public Visitante() { }



        // ------------------------------------- GETTERS E SETTERS -------------------------------------
        public string Cartao_cidadao { get => cartao_cidadao; set => cartao_cidadao = value; }
        public string Nome { get => nome; set => nome = value; }

        public override String ToString()
        {
            return Nome + " | " + Cartao_cidadao;
        }
    }
}
