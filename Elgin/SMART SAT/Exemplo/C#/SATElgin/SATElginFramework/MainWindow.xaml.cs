using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.IO;
using Microsoft.WindowsAPICodePack.Dialogs;
using Microsoft.Win32;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    /// <summary>
    /// Interação lógica para MainWindow.xam
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            VendasSAT.CaminhoXML = "./arquivoVenda.xml";
            VendasSAT.CaminhoXMLCancelamento = "./arquivoCancelamento.xml";
            VendasSAT.CaminhoXMLNFCe = "./xml_elgin_nfce/1425 130519 173801.xml";
            VendasSAT.RetornoXMLAssinado = null;
            GeradorPDF.ArquivoSelecionado = false;
            GeradorPDF.ArquivoSelecionadoNFCe = false;
        }

        private void GeraXML_Click(object sender, RoutedEventArgs e)
        {
            VendasSAT.GeraXMLVenda();
        }

        private void ProcessaVenda_Click(object sender, RoutedEventArgs e)
        {
            VendasSAT.ProcessaXML();
        }
        
        private void CriarPDFSAT_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.GeraPDF();
        }

        private void Fechar_Click(object sender, RoutedEventArgs e) => FechJanela();

        private void FechJanela()
        {
            Close();
        }

        private void EscolheDiretorio_Click(object sender, RoutedEventArgs e)
        {
            CommonOpenFileDialog dlg = new CommonOpenFileDialog();
            dlg.InitialDirectory = AppDomain.CurrentDomain.BaseDirectory;
            dlg.IsFolderPicker = true;
            dlg.Multiselect = false;
            dlg.Title = "Selecionar arquivo";
            
            if (dlg.ShowDialog() == CommonFileDialogResult.Ok) { caminho_root_pastas.Text = dlg.FileName; }
            else { caminho_root_pastas.Text = "./"; }
        }

        private void GerarXML2_Click(object sender, RoutedEventArgs e)
        {
            VendasSAT.GeraXMLVenda2(caminho_root_pastas.Text);
        }

        private void GerarXMLCancelamento_Click(object sender, RoutedEventArgs e)
        {
            if(ChaveAcessoXML.Text != "")
            {
            VendasSAT.GeraCancelamentoXML(ChaveAcessoXML.Text);
            }
            else
            {
                MessageBox.Show("Por favor, antes de gerar o cancelamento escrever a chave de acesso do XML");
            }
        }

        private void ProcessarXMLCancelamento_Click(object sender, RoutedEventArgs e)
        {
            VendasSAT.FechaCancelamentoXML();
        }
        private void EscolheDiretorioCriarPDF_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.SelecionaArquivo("XML Files | *.xml");
        }

        private void EscolheDiretorioPDF_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.SelecionaArquivo("PDF Files | *.pdf");
        }

        private void CriarPDFCancelamento_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.GeraPDFCancelamento();
        }

        private void ConfigurarDiretorioSaida_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.ConfiguraCaminhoPDF();
        }

        private void ConectarImpressora_Click(object sender, RoutedEventArgs e)
        {
            JanelaConectaImpressora j = new JanelaConectaImpressora();
            j.ShowDialog();
            j.Focus();
        }

        private void CriarPDFNFCe_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.GeraPDFNFCe();
        }

        private void ImprimirPDF_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.ImprimirPDF();
        }

        private void GetUltimoPDFGerado_Click(object sender, RoutedEventArgs e)
        {
            IntPtr caminho_intptr = E1PDF.ObtemUltimoArquivo();
            string caminho = Marshal.PtrToStringAnsi(caminho_intptr);
            if (caminho != "")
            {
                MessageBox.Show($"{caminho}\n\nPara imprimir com sua impressora padrão do windows clique em \"OK\"", "Caminho Último PDF Gerado");
                GeradorPDF.Imprimir(caminho);
            }
            else { MessageBox.Show("Ainda não foi criado nenhum arquivo."); }
        }

        private void ImprimirPDFE1_Click(object sender, RoutedEventArgs e)
        {
            ImpressoraModel.ImprimePDF417();
        }

        private void ImprimirXMLSATE1_Click(object sender, RoutedEventArgs e)
        {
            ImpressoraModel.ImprimeXMLSAT();
        }

        private void ImprimirXMLCancelamentoE1_Click(object sender, RoutedEventArgs e)
        {
            ImpressoraModel.ImprimeXMLSATCancelamento();
        }

        private void ImprimirNFCeE1_Click(object sender, RoutedEventArgs e)
        {
            ImpressoraModel.ImprimeXMLNFCe();
        }

        private void EscolheNFCe_Click(object sender, RoutedEventArgs e)
        {
            GeradorPDF.SelecionaNFCE();
        }
    }
}
