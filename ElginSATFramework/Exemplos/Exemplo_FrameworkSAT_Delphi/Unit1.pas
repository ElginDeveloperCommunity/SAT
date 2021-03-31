unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2, System.StrUtils;

type
  TForm1 = class(TForm)
    GroupBox2: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button2: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  path = AnsiString('arquivoVenda.xml');
  path_canc = AnsiString('arquivoCancelamento.xml');

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  retornoSat : String;

begin
  retornosat := FechaCupomCancelamento(path_canc, '123456789');
  ShowMessage(retornoSat);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  retornoSat : PAnsiChar;
  dadosVenda : TArray<String>;
begin
  retornosat := fechaCupomVenda(path, '123456789');
  ShowMessage(retornoSat);

  dadosVenda := SplitString(retornoSat, '|');

  if Length(dadosVenda) > 1 then
  begin
    if dadosVenda[1] = '06000' then
    begin
        Edit1.Text := dadosVenda[8];
    end;
  end;



end;

procedure TForm1.Button3Click(Sender: TObject);
var
  nitem:Integer;
  retornoSAT:String;
begin

  AbreCupomVenda(path,                                               //Caminho arquivo
                 '0.08',                                             //layout do xml
                 '16716114000172',                                   //CNPJ SH
                 'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT',    //Assinatura SH
                 123,                                                //Numero caixa
                 '14200166000166',                                   //CNPJ Emitente
                 '111111111111',                                     //IE
                 '123123',                                           //IM
                 '',                                                 //Regime Especial de Tributação do ISSQN
                 'n',                                                //Indicador de rateio do Desconto sobre subtotal entre itens sujeitos à tributação pelo ISSQN
                 '',                                                 //CNPJ Destinatário
                 '',                                                 //CPF Destinatário
                 '');                                                //Razão Social ou Nome do destinatário

  nitem := informaProduto(path,     //caminho arquivo
                          '0001',   //cprod
                          '',       //cean
                          'CEST',   //xprod
                          '47061000',//ncm
                          '1234567',//cest
                          '5757',   //cfop
                          'kg',     //ucom
                          '1.0000', //qcom
                          '100.00', //vuncom
                          'a',      //indregra
                          '',       //vdesc
                          '');      //voutro

  informaImposto(path, nitem, '1.00');

  informaICMS40(path, nitem, 3, '40');

  informaPISNT(path, nitem, '04');

  informaCOFINSNT(path, nitem, '04');

  informaTotal(path, '', '', '');

  informaPgto(path, '01', '100.00', '');

  ShowMessage('ok');

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AbreCupomCancelamento(path_canc,
                        Edit1.Text,
                        '14200166000166',
                        'SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT',
                        123);
  ShowMessage('ok');
end;

end.


