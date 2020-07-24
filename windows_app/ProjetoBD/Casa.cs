using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Casa
    {
        private int id;
        private String morada;
        private String telefone;
        public Casa() { }

        public int Id { get => id; set => id = value; }
        public string Morada { get => morada; set => morada = value; }
        public String Telefone { get => telefone; set => telefone = value; }

        public override String ToString()
        {
            if(this.Telefone.Length>0)
                return Morada + " | " + Telefone;
            else return Morada;
        }
    }
}
