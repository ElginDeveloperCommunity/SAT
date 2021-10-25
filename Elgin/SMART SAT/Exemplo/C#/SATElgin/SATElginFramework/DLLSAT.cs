using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    class DLLSAT
    {
        public const string PATH = "./dllsat.dll";
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern string EnviarDadosVenda(int num_sessao, string cod_ativacao, string dados_venda);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int GeraNumeroSessao();
    }
}
