using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    class E1PDF
    {
        public const string PATH_DLL = "./E1_Pdf02.dll";

        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern int GeraPDFSAT(string dados, int parametro);

        /// <summary>
        /// <b>Gera PDF Danfe de cancelamento SAT.</b><br></br> 
        /// Essa função recebe o XML de retorno da operação de cancelamento e os dados de assinatura do QRCode de venda, valida as informações, constrói o Danfe e realiza geração do cupom no formato PDF de acordo com a especificação da SEFAZ SP.
        /// </summary>
        /// <param name="dados">dados - Conteúdo do XML de cancelamento retornado pelo SAT.</param>
        /// <param name="assQrCode">Assinatura do QRCode retornado na operação de Venda.Essa informação é necessária porque o XML de retorno da operação de venda não a contém.</param>
        /// <param name="parametro">Parâmetro do tipo numérico para ativar bits que modificam o cupom a ser impresso.<br></br>O valor passado ao parâmetro deve ser a soma dos valores inteiros correspondentes aos bits desejados.<br></br>O valor 0 não ativa nenhum bit e imprime o cupom padrão.</param>
        /// <returns></returns>
        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern int GeraPDFSATCancelamento(string dados, string assQrCode, int parametro);
        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern int GeraPDFNFCe(string dados, int indexcsc, string CSC, int parametro);
        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImprimePDF(string caminho);
        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ConfiguraDiretorioSaida(string caminho);
        [DllImport(PATH_DLL, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr ObtemUltimoArquivo();
    }
}
