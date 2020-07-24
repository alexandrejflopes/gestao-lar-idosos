using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Quarto
    {
        private int id;
        private int numero;
        private String detalhes;

        public Quarto(int numero)
        {
            this.Numero = numero;
        }

        public Quarto() { }

        public int Numero { get => numero; set => numero = value; }
        public string Detalhes { get => detalhes; set => detalhes = value; }
        public int Id { get => id; set => id = value; }


        public override String ToString()
        {
            return numero + " | " + detalhes;
        }
    }
}
