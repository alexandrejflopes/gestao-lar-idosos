using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjetoBD
{
    public class Ligacao
    {

        public SqlConnection getSGBDConnection(SqlConnection cn)
        {
            /*String BDaula = "Data Source = " + "tcp:mednat.ieeta.pt\\SQLSERVER,8101" + " ;" + "Initial Catalog = " + "p5g1" +
                                                       "; uid = " + "p5g1" + ";" + "password = " + password;*/

            String fonteDados = "data source= LAPTOP-KCTDTO9B;integrated security=true;initial catalog=testesProjeto";

            if (cn == null) { cn = new SqlConnection(fonteDados); }

            if (cn.State != ConnectionState.Open) { cn.Open(); }

            return cn;
        }

        public bool verifySGBDConnection(SqlConnection cn)
        {
            return cn.State == ConnectionState.Open;
        }
    }
}
