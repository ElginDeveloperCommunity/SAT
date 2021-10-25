using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.IO;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    class VendasSAT
    {
        // propriedade que guarda o caminho do arquivoVenda.xml atual
        public static string CaminhoXML { get; set; }

        // propriedade que guarda o caminho do xml de cancelamento
        public static string CaminhoXMLCancelamento { get; set; }

        // propriedade que guarda o caminho do xml nfce para geração do pdf
        public static string CaminhoXMLNFCe { get; set; }

        // propriedade que guarda o retorno da função FechaCupomVenda() para que possa ser usado para criação do pdf
        public static string RetornoXMLAssinado { get; set; }

        // chama todas as funções necessárias para criar o xml
        public static void GeraXMLVenda()
        {
            const string PATH_XML = "./arquivoVenda.xml";

            int[] ret_comparacao = { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            int[] ret = new int[12];
            ret[0] = E1SAT.AbreCupomVenda(PATH_XML, "0.08", "16716114000172", "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT", 123, "14200166000166", "111111111111", "123123", "", "n", "", "", "");
            ret[1] = E1SAT.InformaEntrega(PATH_XML, "Rua Aruana", "32", "", "Urbanova", "Sao Jose dos Campos", "SP");
            ret[2] = E1SAT.InformaProduto(PATH_XML, "116", "", "cubo magico", "", "", "5102", "48329", "1.0000", "32.00", "A", "", "");
            ret[3] = E1SAT.InformaObsFiscoDet(PATH_XML, 1, "Cod. CEST", "999999999");
            ret[4] = E1SAT.InformaImposto(PATH_XML, 1, "");
            ret[5] = E1SAT.InformaICMS40(PATH_XML, 1, 0, "40");
            ret[6] = E1SAT.InformaPISSN(PATH_XML, 1, "49");
            ret[7] = E1SAT.InformaCOFINSSN(PATH_XML, 1, "49");
            ret[8] = E1SAT.InformaInfAdProd(PATH_XML, 1, "Cubo mágico produzido pela cuberbrasil");
            ret[9] = E1SAT.InformaTotal(PATH_XML, "", "", "");
            ret[10] = E1SAT.InformaPgto(PATH_XML, "01", "32.00", "");
            ret[11] = E1SAT.InformaInfAdic(PATH_XML, "");

            if (ret.SequenceEqual(ret_comparacao)) { MessageBox.Show("XML Venda Criado"); CaminhoXML = PATH_XML; }
            else { MessageBox.Show("Ocorreu um erro com uma das funções de informação do produto, por favor, por meio de debug verificar qual função está dando problema!"); }

        }

        // envia o xml para o SAT para ter a assinatura digital
        public static void ProcessaXML()
        {
            string PATH_XML = CaminhoXML;
            IntPtr retorno;

            retorno = E1SAT.FechaCupomVenda(PATH_XML, "123456789");
            RetornoXMLAssinado = Marshal.PtrToStringAnsi(retorno);
            MessageBox.Show(RetornoXMLAssinado);

            // reseta ArquivoSelecionado para que a classe geraPDF possa usar o cupom criado nesta função
            GeradorPDF.ArquivoSelecionado = false;
        }

        // chama funções necessárias para criar o xml da venda
        // retorno da função AbreCupomVenda2 => char * (ponteiro de char no C, para cada linguagem encontrar o equivalente
        // No caso do C#, uma maneira é receber como IntPtr e então converter para string
        public static void GeraXMLVenda2(string diretorio)
        {
            IntPtr retorno;
            string PATH_XML;
            int[] ret_comparacao = { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
            int[] ret = new int[11];

            retorno = E1SAT.AbreCupomVenda2(diretorio, "0.08", "16716114000172", "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT", 123, "14200166000166", "111111111111", "123123", "", "n", "", "", "");
            PATH_XML = Marshal.PtrToStringAnsi(retorno);

            ret[0] = E1SAT.InformaEntrega(PATH_XML, "Rua Aruana", "32", "", "Urbanova", "Sao Jose dos Campos", "SP");
            ret[1] = E1SAT.InformaProduto(PATH_XML, "116", "", "cubo magico", "", "", "5102", "48329", "1.0000", "32.00", "A", "", "");
            ret[2] = E1SAT.InformaObsFiscoDet(PATH_XML, 1, "Cod. CEST", "999999999");
            ret[3] = E1SAT.InformaImposto(PATH_XML, 1, "");
            ret[4] = E1SAT.InformaICMS40(PATH_XML, 1, 0, "40");
            ret[5] = E1SAT.InformaPISSN(PATH_XML, 1, "49");
            ret[6] = E1SAT.InformaCOFINSSN(PATH_XML, 1, "49");
            ret[7] = E1SAT.InformaInfAdProd(PATH_XML, 1, "Cubo mágico produzido pela cuberbrasil");
            ret[8] = E1SAT.InformaTotal(PATH_XML, "", "", "");
            ret[9] = E1SAT.InformaPgto(PATH_XML, "01", "32.00", "");
            ret[10] = E1SAT.InformaInfAdic(PATH_XML, "");

            if (ret.SequenceEqual(ret_comparacao)) { MessageBox.Show($"XML Venda Criado em: \n\n {PATH_XML}"); CaminhoXML = PATH_XML; }
            else { MessageBox.Show("Ocorreu algum erro durante a criação do XML."); }
        }

        // Abre o cupom do cancelamento, é necessária a chave de acesso, que se encontra no id do xml de venda.
        // Neste exemplo, o próprio usuário digita/cola a chave de acesso na TextBox na GUI.
        public static void GeraCancelamentoXML(string chave_de_acesso)
        {
            string PATH_XML = CaminhoXML;
            int ret = E1SAT.AbreCupomCancelamento(PATH_XML, chave_de_acesso, "16716114000172", "SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT", 123);

            if (ret == 0) { MessageBox.Show($"XML Cancelamento criado em: \n\n {PATH_XML}"); }
            else if (ret == -401) { MessageBox.Show("(-401) Chave de cancelamento com tamanho diferente de 47 ou não iniciado com prefixo CFe."); }
            else { MessageBox.Show($"Ocorreu algum erro durante a criação do XML.\n\n{ret}\n{PATH_XML}"); }
        }

        // Fecha Cancelamento - envia para o SAT e retorna o caminho do arquivo já assinado
        public static void FechaCancelamentoXML()
        {
            string PATH_XML = CaminhoXML;
            IntPtr ret = E1SAT.FechaCupomCancelamento(PATH_XML, "123456789");
            CaminhoXMLCancelamento = Marshal.PtrToStringAnsi(ret);
            if (CaminhoXMLCancelamento.Contains("C:")) { MessageBox.Show(CaminhoXMLCancelamento, "Caminho arquivo Cancelamento xml"); }
            else { MessageBox.Show("Ocorreu algum erro no cancelamento do cupom."); }
            
        }
    }
}
