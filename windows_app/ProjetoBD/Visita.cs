using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Visita
    {
        private int no_utente;
        private String nome_utente;
        private String nome_visitante;
        private String cc_visitante;
        private String data;
        private String hora_entrada;
        private String hora_saida;

        public Visita() { }

        public int No_utente { get => no_utente; set => no_utente = value; }
        public string Cc_visitante { get => cc_visitante; set => cc_visitante = value; }
        public string Data { get => data; set => data = value; }
        public string Hora_entrada { get => hora_entrada; set => hora_entrada = value; }
        public string Hora_saida { get => hora_saida; set => hora_saida = value; }
        public string Nome_utente { get => nome_utente; set => nome_utente = value; }
        public string Nome_visitante { get => nome_visitante; set => nome_visitante = value; }

        public override String ToString()
        {
            return Nome_utente + " | " + Cc_visitante + " | " + Data;
        }
    }
}
