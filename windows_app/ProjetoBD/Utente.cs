using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Utente
    {
        private String _no_utente;
        private String _cc_responsavel;
        private String _id_alojamento;
        private String _nome;
        private String _fotografia;
        private String _alcunha;
        private String _data_nasc;
        private String _sexo;
        private String _estado_civil;
        private String _NIF;
        private String _morada_anterior;
        private String _data_entrada;
        private String _sns;
        private String _niss;
        private String _subsistema_saude;
        private String _grau_dependencia;
        private String _num_telemovel;

        public Utente(String Name)
        {
            this.Nome = Name;
        }

        public Utente() { }



        // ------------------------------------- GETTERS E SETTERS -------------------------------------
        public string No_utente { get => _no_utente; set => _no_utente = value; }
        public string Cc_responsavel { get => _cc_responsavel; set => _cc_responsavel = value; }
        public string Id_alojamento { get => _id_alojamento; set => _id_alojamento = value; }
        public string Nome { get => _nome; set => _nome = value; }
        public string Fotografia { get => _fotografia; set => _fotografia = value; }
        public string Alcunha { get => _alcunha; set => _alcunha = value; }
        public string Data_nasc { get => _data_nasc; set => _data_nasc = value; }
        public string Sexo { get => _sexo; set => _sexo = value; }
        public string Estado_civil { get => _estado_civil; set => _estado_civil = value; }
        public string NIF { get => _NIF; set => _NIF = value; }
        public string Morada_anterior { get => _morada_anterior; set => _morada_anterior = value; }
        public string Data_entrada { get => _data_entrada; set => _data_entrada = value; }
        public string Sns { get => _sns; set => _sns = value; }
        public string Niss { get => _niss; set => _niss = value; }
        public string Subsistema_saude { get => _subsistema_saude; set => _subsistema_saude = value; }
        public string Grau_dependencia { get => _grau_dependencia; set => _grau_dependencia = value; }
        public string Num_telemovel { get => _num_telemovel; set => _num_telemovel = value; }

        public override String ToString()
        {
            return No_utente + " | " + Nome;
        }



        




    }
}


