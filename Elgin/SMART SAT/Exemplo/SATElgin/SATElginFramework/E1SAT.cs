using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    class E1SAT
    {
        public const string PATH = "./E1_SAT01.dll";

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int AbreCupomVenda(string path_file, string layout, string cnpj, string assinatura, int n_caixa, string cnpj_emitente, string ie, string im, string issqn, string rateio, string cnpj_destinatario, string cpf, string razao_social);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr AbreCupomVenda2(string path_root, string layout, string cnpj, string assinatura, int n_caixa, string cnpj_emitente, string ie, string im, string issqn, string rateio, string cnpj_destinatario, string cpf, string razao_social);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaEntrega(string path_file, string xLgr, string nro, string xCpl, string xBairro, string xMun, string UF);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaProduto(string path_file, string cProd, string cEAN, string xProd, string NCM, string CEST, string CFOP, string uCom, string qCom, string vUnCom, string indRegra, string vDesc, string vOutro);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaObsFiscoDet(string path_file, int n_item, string x_campo_det, string x_texto_det);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaImposto(string path_file, int n_item, string v_item_12741);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaICMS40(string path_file, int n_item, int orig, string cst);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaPISSN(string file, int n_item, string cst);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaCOFINSSN(string path_file, int n_item, string cst);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaInfAdProd(string path_file, int n_item, string inf_ad_prod);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaTotal(string path_file, string v_desc_sub_tot, string v_acres_sub_tot, string v_cfe_lei_12741);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaPgto(string path_file, string cmp, string vmp, string c_adm_c);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int InformaInfAdic(string path_file, string inf_cpl);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr FechaCupomVenda(string path_file, string codigo_ativacao_sat);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int AbreCupomCancelamento(string path_file, string chCanc, string CNPJ, string signAC, int numeroCaixa);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr AbreCupomCancelamento2(string path_root, string chCanc, string CNPJ, string signAC, int numeroCaixa);
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern IntPtr FechaCupomCancelamento(string path_file, string codigo_ativacao);



    }
}
