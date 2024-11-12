using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace SATElginFramework
{
    class E1Impressora
    {
        // declaração dos métodos da dll
        public const string PATH = "./E1_Impressora01.dll";

        /// <summary>
        /// Abre conexão com a impressora.
        /// </summary>
        /// <param name="tipo">Parâmetro do tipo numérico que define o tipo de comunicação que será estabelecido. <br></br>Conforme tabela a seguir:<br></br>1 = USB<br></br>2 = RS232<br></br>3 = TCP/IP<br></br>4 = Bluetooth<br></br>5 = Impressoras acopladas (Android)</param>
        /// <param name="modelo"> Parâmetro tipo caractere que especifica o modelo para conexão.</param>
        /// <param name="conexao">Parâmetro tipo caractere que define detalhes de conexão. (USB, COM1, ...)</param>
        /// <param name="param">Parâmetro do tipo numérico auxiliar para a conexão com a impressora. Utilizado para especificar baudrate ou porta de comunicação TCP/IP. OBS: Quando a conexão estabelecida for USB ou Bluetooth esse parâmetro é desconsiderado e pode ser definido como valor 0. OBS: Esse parâmetro é desconsiderado se o tipo da impressora for o 5, podendo ser definido como 0 (zero).</param>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int AbreConexaoImpressora(int tipo, string modelo, string conexao, int param);


        /// <summary>
        /// Fecha conexão com a impressora
        /// </summary>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int FechaConexaoImpressora();

        /// <summary>
        /// Realiza a impressão de PDF417, com possibilidade de variação de tamanho e nível de correção.
        /// </summary>
        /// <param name="numCols">Parâmetro do tipo numérico que define o número de colunas. \nValores válidos: Números entre 0 e 30 (0, 1, 2, ..., 30). \nOBS: O valor 0 significa processamento automático.</param>
        /// <param name="numRows">Parâmetro do tipo numérico que define o número de linhas. \nValores válidos: Números entre 3 e 90 (3, 4, 5, ..., 90) ou 0. \nOBS: O valor 0 significa processamento automático.</param>
        /// <param name="width">Parâmetro do tipo numérico que define a largura do módulo, em pontos. \nValores válidos: Números entre 2 e 8 (2, 3, 4, ..., 8). \nOBS: Se o tipo de conexão estiver definido como 5, este parâmetro definirá a largura preferencial do módulo, em pixels, e os valores válidos serão todos os números inteiros positivos(0, 1, 2, ...).</param>
        /// <param name="height">Parâmetro do tipo numérico que define a altura da linha, multiplicando o valor definido pela largura do módulo (configurada em width). \nValores válidos: Números entre 2 e 8 (2, 3, 4, ..., 8). \nOBS: Se o tipo de conexão estiver definido como 5, este parâmetro definirá a altura preferencial do módulo, em pixels, e os valores válidos serão todos os números inteiros positivos(0, 1, 2, ...).</param>
        /// <param name="errCorLvl">Parâmetro do tipo numérico que define o nível de correção de erro. [0-8]</param>
        /// <param name="options">Parâmetro do tipo numérico que define a opção para PDF417. 0 ou 1</param>
        /// <param name="dados">Parâmetro do tipo caractere que define o código a ser impresso. \nValores válidos: Qualquer string de dados imprimíveis; máximo de 65532 caracteres.</param>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImpressaoPDF417(int numCols, int numRows, int width, int height, int errCorLvl, int options, string dados);

        /// <summary>
        /// <b>Imprime Danfe SAT.</br>Essa função recebe o XML de retorno da venda do SAT, valida o conteúdo, constrói o Danfe e realiza a impressão de acordo com a especificação da SEFAZ SP.<br></br>A função bem sucedida deve retornar 0.
        /// </summary>
        /// <param name="dados"> Conteúdo do XML de retorno da venda do SAT ou Caminho para arquivo com dados do SAT prefixado com "path=", <br></br> ex: path=C:/Resposta SAT/CFe35210130197161000935590008544130085892910578.xml</param>
        /// <param name="param">Parâmetro do tipo numérico para ativar bits que modificam o cupom a ser impresso.<br></br> Os bits disponíveis e seus respectivos efeitos no cupom(quando ativados) são descritos na documentação:</param>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImprimeXMLSAT(string dados, int param);

        /// <summary>
        /// <b>Imprime Danfe de cancelamento SAT.</b>Essa função recebe o XML de retorno da operação de cancelamento e os dados de assinatura do QRCode de venda, valida as informações, constrói o Danfe e realiza impressão de acordo com a especificação da SEFAZ SP.
        /// </summary>
        /// <param name="dados">Conteúdo do XML de cancelamento retornado pelo SAT ou Caminho para arquivo com dados do SAT prefixado com "path=", <br></br>ex: path=C:/Resposta SAT/CFe35210130197161000935590008544130085892910578.xml</param>
        /// <param name="assQRCode">Assinatura do QRCode retornado na operação de Venda. Essa informação é necessária porque o XML de retorno da operação de venda não a contém.</param>
        /// <param name="param">Parâmetro do tipo numérico para ativar bits que modificam o cupom a ser impresso.</param>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImprimeXMLCancelamentoSAT(string dados, string assQRCode, int param);

        /// <summary>
        /// <b>Imprime o Danfe NFCe.</b><br></br>Essa função recebe o conteúdo do XML de venda do NFCe, valida o conteúdo, constrói o Danfe e realiza a impressão.
        /// </summary>
        /// <param name="dados"><b>Imprime o Danfe NFCe.</b><br></br> Essa função recebe o conteúdo do XML de venda do NFCe, valida o conteúdo, constrói o Danfe e realiza a impressão.</param>
        /// <param name="indexcsc">Identificador do CSC (Código de Segurança do Contribuinte no Banco de Dados da SEFAZ). Deve ser informado sem os “0” (zeros) não significativos.A identificação do CSC corresponde à ordem do CSC no banco de dados da SEFAZ, não confundir com o próprio CSC.</param>
        /// <param name="csc">Código de Segurança do Contribuinte. <br></br>Corresponde a um código de segurança alfanumérico(16 a 36 bytes) de conhecimento apenas da Secretaria da Fazenda da Unidade Federada do emitente e do próprio contribuinte.Anteriormente, o código de segurança CSC era chamado de “Token”.</param>
        /// <param name="parametro">Parâmetro do tipo numérico para ativar bits que modificam o cupom a ser impresso. Os bits disponíveis e seus respectivos efeitos no cupom(quando ativados) são descritos na documentação:</param>
        /// <returns></returns>
        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImprimeXMLNFCe(string dados, int indexcsc, string csc, int parametro);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int Corte(int avanco);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int AvancaPapel(int linhas);

        [DllImport(PATH, CallingConvention = CallingConvention.StdCall)]
        internal static extern int ImpressaoTexto(string dados, int posicao, int stilo, int tamanho);
		
    }
}
