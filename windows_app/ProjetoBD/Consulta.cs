using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Consulta
    {
        private int numero;
        private int ano;
        private String nUtente;
        private String data;
        private int numMedico;
        private String nomeMedico;

        public Consulta() { }

        public int Numero { get => numero; set => numero = value; }
        public int Ano { get => ano; set => ano = value; }
        public String NUtente { get => nUtente; set => nUtente = value; }
        public string Data { get => data; set => data = value; }
        public int NumMedico { get => numMedico; set => numMedico = value; }
        public string NomeMedico { get => nomeMedico; set => nomeMedico = value; }

        public override String ToString()
        {
            return Numero + " | " + Data + " | " +  NomeMedico;
        }
    }
}
