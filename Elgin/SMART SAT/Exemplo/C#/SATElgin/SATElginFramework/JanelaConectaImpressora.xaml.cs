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
using System.Windows.Shapes;

namespace SATElginFramework
{
    /// <summary>
    /// Lógica interna para JanelaConectaImpressora.xaml
    /// </summary>
    public partial class JanelaConectaImpressora : Window
    {
        public JanelaConectaImpressora()
        {
            InitializeComponent();
        }

        // define as variáveis de conexão com a impressora e verifica se é possível estabelecer a comunicação
        private void BtnConectar_Click(object sender, RoutedEventArgs e)
        {
            ImpressoraModel.tipo = int.Parse(lblTipo.Text);
            ImpressoraModel.modelo = lblModelo.Text;
            ImpressoraModel.conexao = lblConexao.Text;
            ImpressoraModel.param = int.Parse(lblParam.Text);

            int ret = E1Impressora.AbreConexaoImpressora(ImpressoraModel.tipo, 
                                                         ImpressoraModel.modelo, 
                                                         ImpressoraModel.conexao, 
                                                         ImpressoraModel.param);
            E1Impressora.FechaConexaoImpressora();
            if (ret == 0)
            {
                MessageBox.Show("Sua Impressora está conectada!", "Conexão Impressora");
            }
            else
            {
                MessageBox.Show($"A conexão com a impressora não pode ser feita por causa do erro: \n\n{ret}", "Conexão Impressora");
            }
        }
    }
}
