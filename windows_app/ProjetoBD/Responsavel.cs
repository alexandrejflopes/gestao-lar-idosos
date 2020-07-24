using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Responsavel
    {
        private String cc;
        private String nome;
        private String morada;
        private String tipo;
        private String telemovel;
        public Responsavel() { }

        public string Cc { get => cc; set => cc = value; }
        public string Nome { get => nome; set => nome = value; }
        public string Morada { get => morada; set => morada = value; }
        public string Tipo { get => tipo; set => tipo = value; }
        public string Telemovel { get => telemovel; set => telemovel = value; }

        public override String ToString()
        {
            return Nome + " (" + Cc + ")";
        }
    }
}
