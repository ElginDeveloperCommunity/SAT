using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;
using System.Windows;
using Microsoft.WindowsAPICodePack.Dialogs;
using System.IO;
using System.Xml;

namespace SATElginFramework
{
    class GeradorPDF
    {
        // propriedade para identificar se foi escolhido ou não um arquivo para gerar o pdf, ou se deve-se usar o último gerado
        public static bool ArquivoSelecionado { get; set; }
        public static bool ArquivoSelecionadoNFCe { get; set; }
        
        // cria pdf a partir do último xml que foi fechado
        public static void GeraPDF()
        {
            if(ArquivoSelecionado == false && VendasSAT.RetornoXMLAssinado != null)
            {
                string xml_assinado = VendasSAT.RetornoXMLAssinado;
                int retorno = E1PDF.GeraPDFSAT(xml_assinado, 0);
                if (retorno == 0) { MessageBox.Show($"PDF Criado\n"); }
                else { MessageBox.Show($"Erro inesperado na criação do XML\n\n {retorno}"); }
            }
            else
            {
                if (File.Exists(VendasSAT.CaminhoXML))
                {
                    string xml_assinado = Convert.ToBase64String(File.ReadAllBytes(VendasSAT.CaminhoXML));
                    int retorno = E1PDF.GeraPDFSAT(xml_assinado, 0);
                    if (retorno == 0) { MessageBox.Show($"PDF Criado em\n{VendasSAT.CaminhoXML}"); }
                    else { MessageBox.Show($"Erro inesperado na criação do XML\n\n {retorno}"); }
                }
                else
                {
                    MessageBox.Show("Arquivo ./arquivoVenda.xml não existe!");
                }
            }
        }

        // se o usuário preferir, pode selecionar algum arquivo xml específico para criar o pdf
        public static void SelecionaArquivo(string filetype)
        {
            OpenFileDialog dlgfile = new OpenFileDialog
            {
                Filter = filetype,
                Title = "Selecione o arquivo para gerar o pdf",
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory
            };

            if (dlgfile.ShowDialog() == true)
            {
                VendasSAT.CaminhoXML = dlgfile.FileName;
                ArquivoSelecionado = true;
            }
            else
            {
                MessageBox.Show("Nenhum arquivo foi selecionado, o último XML criado será utilizado");
                ArquivoSelecionado = false;
            }
        }

        // Gera pdf cancelamento
        public static void GeraPDFCancelamento()
        {
            string assQRCode = GetQRCode();
          
            if (ArquivoSelecionado == false && VendasSAT.RetornoXMLAssinado != null)
            {
                string xml_assinado = VendasSAT.RetornoXMLAssinado;
                int retorno = E1PDF.GeraPDFSATCancelamento(xml_assinado, assQRCode, 0);
                if (retorno == 0) { MessageBox.Show($"PDF Cancelamento criado em: \n"); }
                else { MessageBox.Show($"Ocorreu algum erro durante a criação do XML.\n\n{retorno}\n{xml_assinado}"); }
            }
            else
            {
                if (File.Exists(VendasSAT.CaminhoXMLCancelamento))
                {
                    string xml_assinado = Convert.ToBase64String(File.ReadAllBytes(VendasSAT.CaminhoXMLCancelamento));
                    int retorno = E1PDF.GeraPDFSATCancelamento(xml_assinado, assQRCode, 0);
                    if (retorno == 0) { MessageBox.Show($"PDF de Cancelamento Criado em\n{VendasSAT.CaminhoXMLCancelamento}"); }
                    else { MessageBox.Show($"Erro inesperado na criação do XML\n\n {retorno}"); }
                }
                else
                {
                    MessageBox.Show("Arquivo ./arquivoVenda.xml não existe!");
                }
            }
        }

        // seleciona arquivo xml nfce
        public static void SelecionaNFCE()
        {
            OpenFileDialog dlgfile = new OpenFileDialog
            {
                Filter = "XML Files | *.xml",
                Title = "Selecione um arquivo .xml dessa pasta para gerar o pdf NFCe",
                InitialDirectory = AppDomain.CurrentDomain.BaseDirectory + "xml_elgin_nfce\\"
        };

            if (dlgfile.ShowDialog() == true)
            {
                VendasSAT.CaminhoXMLNFCe = dlgfile.FileName;
                ArquivoSelecionadoNFCe = true;
            }
            else
            {
                MessageBox.Show("Nenhum arquivo foi selecionado, o último XML criado será utilizado");
                ArquivoSelecionadoNFCe = false;
            }
        }

        // Criar pdf nfc-e 
        // Usa xml nfce prontos no caminho ./xml_elgin_nfce/*.xml
        public static void GeraPDFNFCe()
        {
            if (ArquivoSelecionadoNFCe)
            {
                int retorno;
                string xml_assinado = Convert.ToBase64String(File.ReadAllBytes(VendasSAT.CaminhoXMLNFCe));
                int indexcsc = 0;
                string csc = "CODIGO-CSC-CONTRIBUINTE-36-CARACTERES";
                retorno = E1PDF.GeraPDFNFCe("path="+VendasSAT.CaminhoXMLNFCe, indexcsc, csc, 0);
                if (retorno == 0) { MessageBox.Show($"PDF NFC-e criado!\n",""); }
                else { MessageBox.Show($"Ocorreu algum erro durante a criação do XML.\n\n{retorno}"); }
            }
            else { SelecionaNFCE(); }
        }
        
        // função do botão que configura o diretório de saída dos pdf gerados
        public static void ConfiguraCaminhoPDF()
        {
            CommonOpenFileDialog dlg = new CommonOpenFileDialog
            {
                InitialDirectory = VendasSAT.CaminhoXML,
                IsFolderPicker = true,
                Multiselect = false,
                Title = "Selecionar arquivo"
            };

            if (dlg.ShowDialog() == CommonFileDialogResult.Ok)
            {
                int ret = E1PDF.ConfiguraDiretorioSaida(dlg.FileName);
                if (ret == 0) { MessageBox.Show("O diretório de saída foi configurado com sucesso!"); }
                else { MessageBox.Show($"Ocorreu um erro!\n\n{ret}"); }
            }
            else { MessageBox.Show("Selecionar uma pasta por favor!"); }


        }

        // pega QR Code do xml processar venda para criar o pdf de cancelamento
        public static string GetQRCode()
        {
            string xml_assinado = VendasSAT.CaminhoXML;
            string xml_file = File.ReadAllText(xml_assinado);

            int index_inicial = xml_file.IndexOf("<assinaturaQRCODE>") + "<assinaturaQRCODE>".Length;
            int index_final = xml_file.IndexOf("</assinaturaQRCODE>");
            string qrcode = xml_file.Substring(index_inicial, index_final - index_inicial);
            
            return qrcode;
        }

        // verifica se arquivoVenda.xml existe, e então chama a função para imprimir
        public static void ImprimirPDF()
        {
            if (File.Exists(VendasSAT.CaminhoXML))
            {
                Imprimir(VendasSAT.CaminhoXML);
            }
            else
            {
                MessageBox.Show("Antes de Imprimir, crie um arquivo xml", "Aviso");
            }
        }

        // usa método da dll que chama a impressora padrão do windows para imprimir
        public static void Imprimir(string path)
        {
                int retorno = E1PDF.ImprimePDF(path);
                if (retorno == 0) { MessageBox.Show("Seu arquivo foi enviado para a impressora padrão do seu sistema operacional!"); }
                else { MessageBox.Show($"Houve um erro no envio do seu arquivo para a impressora\n\n{retorno}"); }

        }
    }
}
