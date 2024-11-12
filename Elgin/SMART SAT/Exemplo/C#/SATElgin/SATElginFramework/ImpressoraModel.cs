using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace SATElginFramework
{
    class ImpressoraModel
    {
        // declarando variáveis para conexão de impressora
        public static int tipo = 1;
        public static string modelo = "i9";
        public static string conexao = "USB";
        public static int param = 0;

        static string dados = "Ao meu amor serei atento\nAntes, e com tal zelo e sempre e tanto\nQue mesmo em face do maior encanto\nDele se encante mais meu pensamento.\n\nQuero vivê-lo em cada vão momento\nE em seu louvor ei de espalhar meu canto\nE rir meu riso e derramar meu pranto\nAo seu pesar ou seu contantemento\n\nE assim, quando mais tarde me procure\nQuem sabe a morte, angústia de quem vive\nQuem sabe a solidão, fim de quem ama\n\nEu possa me dizer do amor que tive\nQue não seja imortal posto que é chama\nMas que seja infinito enquato dure";

        public static void Imprimir()
        {
            int retorno_conexao = E1Impressora.AbreConexaoImpressora(tipo, modelo, conexao, param);

            if (retorno_conexao == 0)
            {
                E1Impressora.ImpressaoTexto(dados, 0, 1, 0);
                E1Impressora.AvancaPapel(3);
                E1Impressora.Corte(1);
                E1Impressora.FechaConexaoImpressora();
            }
            else if (retorno_conexao == -21)
            {
                MessageBox.Show("Por favor, conectar impressora antes de prosseguir", "Impressora Desconectada");
            }
            else
            {
                MessageBox.Show($"Algo deu errado com a conexão com a impressora, tente revisar as constantes para conexão.\n\n{retorno_conexao}", "Conexão Impressora");
            }
        }

        public static bool TestaConexao()
        {
            int retorno_conexao = E1Impressora.AbreConexaoImpressora(tipo, modelo, conexao, param);
            if(retorno_conexao == 0) { return true; }
            else { MessageBox.Show($"Houve um erro durante a conexão com a impressora.\n{retorno_conexao}", "Testa Conexao"); return false; }
        }

        public static void ImprimePDF417()
        {
            if (TestaConexao())
            {
                int ret = E1Impressora.ImpressaoPDF417(0, 0, 5, 2, 0, 0, "path="+VendasSAT.CaminhoXML);
                E1Impressora.AvancaPapel(3);
                E1Impressora.Corte(1);
                E1Impressora.FechaConexaoImpressora();

                if (ret == 0) { MessageBox.Show("Impressão concluída com sucesso"); }
                else { MessageBox.Show($"Ocorreu algum erro durante a impressão\n{ret}", "Erro Impressão"); }
            }
            else
            { ; }
        }

        public static void ImprimeXMLSAT()
        {
            if (TestaConexao())
            {
                int ret = E1Impressora.ImprimeXMLSAT("path=" + VendasSAT.CaminhoXML, 0);
                E1Impressora.AvancaPapel(3);
                E1Impressora.Corte(1);
                E1Impressora.FechaConexaoImpressora();

                if (ret == 0) { MessageBox.Show("Impressão concluída com sucesso"); }
                else { MessageBox.Show($"Ocorreu algum erro durante a impressão\n{ret}", "Erro Impressão"); }
            }
        }

        public static void ImprimeXMLSATCancelamento()
        {
            if (TestaConexao())
            {
                int ret = E1Impressora.ImprimeXMLCancelamentoSAT("path=" + VendasSAT.CaminhoXMLCancelamento, GeradorPDF.GetQRCode(), 0);
                E1Impressora.AvancaPapel(3);
                E1Impressora.Corte(1);
                E1Impressora.FechaConexaoImpressora();

                if (ret == 0) { MessageBox.Show("Impressão concluída com sucesso"); }
                else { MessageBox.Show($"Ocorreu algum erro durante a impressão\n{ret}", "Erro Impressão"); }
            }
        }

        public static void ImprimeXMLNFCe()
        {
            if (TestaConexao())
            {
                int ret = E1Impressora.ImprimeXMLNFCe("path=" + VendasSAT.CaminhoXMLNFCe, 0, "CODIGO-CSC-CONTRIBUINTE-36-CARACTERES", 0);
                E1Impressora.AvancaPapel(3);
                E1Impressora.Corte(1);
                E1Impressora.FechaConexaoImpressora();

                if (ret == 0) { MessageBox.Show("Impressão concluída com sucesso"); }
                else { MessageBox.Show($"Ocorreu algum erro durante a impressão\n{ret}", "Erro Impressão"); }
            }
        }
    }
}
