unit Home;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FuncoesDLL, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, EncddecD, ConfigurarRede;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    codAtivacao: TEdit;
    cnpjSH: TEdit;
    cnpjContri: TEdit;
    xmlVenda: TEdit;
    xmlCancelamento: TEdit;
    OpenDialog1: TOpenDialog;
    btnXmlVenda: TButton;
    btnXmlCanc: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    GroupBox2: TGroupBox;
    Retorno: TMemo;
    Label6: TLabel;
    AssinaturaAC: TEdit;
    procedure btnXmlVendaClick(Sender: TObject);
    procedure btnXmlCancClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  numSession : Integer;
  aux : string;

implementation

{$R *.dfm}

  function GeraNumeroSessao() : Integer ;
  var
    myfile:TextFile;
    text:string;
    sessao :  Integer;
  begin
    AssignFile(myFile, 'NumeroSessao.txt');


   Reset(myFile);


   while not Eof(myFile)do
   begin
     ReadLn(myFile, text);
     sessao := StrToInt(text);
   end;

   ReWrite(myFile);

   WriteLn(myFile, IntToStr(sessao+1));

   CloseFile(myFile);

   result := sessao;
  end;

procedure TForm1.btnXmlCancClick(Sender: TObject);
begin

    OpenDialog1.filter := '*.xml';
    OpenDialog1.Title := 'Selecione o XML de Venda';

    if OpenDialog1.Execute then
      xmlCancelamento.text := OpenDialog1.FileName
    else
      xmlCancelamento.Text := '';

end;

procedure TForm1.btnXmlVendaClick(Sender: TObject);
begin
    OpenDialog1.filter := '*.xml';
    OpenDialog1.Title := 'Selecione o XML de Venda';

    if OpenDialog1.Execute then
      xmlVenda.text := OpenDialog1.FileName
    else
      xmlVenda.Text := '';
end;

procedure TForm1.Button10Click(Sender: TObject);
begin

if codAtivacao.Text = '' then
begin
  MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
  exit;
end;

  numSession := GeraNumeroSessao;

  aux := AtualizarSoftwareSAT(numSession,codAtivacao.Text);
  Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));

end;

procedure TForm1.Button11Click(Sender: TObject);
var
  val : TStringList;
  aux2 : string;
  i : Integer;

begin
  if codAtivacao.text = '' then
  begin
    MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
    exit;
  end;

  numSession := GeraNumeroSessao;
  aux := ExtrairLogs(numSession,codAtivacao.Text);
  val := TStringList.Create;
  val.Delimiter :='|';
  val.StrictDelimiter := true;
  val.DelimitedText := aux;

  aux2 :='';
  try
    for i := 0 to val.Count-1 do
    begin
      if i=5 then
      begin
        aux2 := aux2 + #13#10 + 'Logs:' + StringReplace(DecodeString(val[5]),'2016',#13#10 + '2016',[rfReplaceAll]);
      end
      else
        aux2 := aux2 + #13#10 +Utf8ToAnsi(val[i]);
    end;
  finally
   val.Free;
  end;

  retorno.Text := aux2;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  if codAtivacao.text = '' then
  begin
    MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
    exit;
  end;

  numSession := GeraNumeroSessao;
  aux := Utf8ToAnsi(BloquearSAT(numSession,codAtivacao.Text));
  Retorno.Text := StringReplace(aux,'|',#13#10,[rfReplaceAll]);

end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  if codAtivacao.text = '' then
  begin
    MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
    exit;
  end;

  numSession := GeraNumeroSessao;
  aux := Utf8ToAnsi(DesbloquearSAT(numSession,codAtivacao.Text));
  Retorno.Text := StringReplace(aux,'|',#13#10,[rfReplaceAll]);
end;

procedure TForm1.Button14Click(Sender: TObject);
var
uf : Integer;
begin

  if codAtivacao.text = '' then
  begin
    MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
    exit;
  end;

  uf := StrToInt(InputBox('Codigo UF', 'Digite o codigo de �rea do estado onde o SAT ser� ativado. Exemplo: 35 = SP / 23 = CE',''));

  if (uf <> 35) and (uf <> 23) then
  begin
    MessageDlg('�nica op��o disponivel no momento � 35 (SP).',mtError,[mbOK],0);
    exit;
  end;

  numSession := GeraNumeroSessao;
  aux := AtivarSAT(numSession,1,codAtivacao.Text,cnpjContri.Text,uf);
  retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  numSession := GeraNumeroSessao;
  aux := ConsultarSAT(numSession);
  retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  if codAtivacao.text = '' then
  begin
    MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
    exit;
  end;

  numSession := GeraNumeroSessao;
  aux := ConsultarStatusOperacional(numSession, codAtivacao.Text);
  Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  str : TStringList;
begin

  if codAtivacao.Text = '' then
  begin
     MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
     codAtivacao.SetFocus;
     exit;
  end;

  if xmlVenda.Text = '' then
  begin
    MessageDlg('Selecione o xml de venda',mtError,[mbOK],0);
    xmlVenda.SetFocus;
    exit;
  end;

   str := TStringList.Create;
   str.LoadFromFile(xmlVenda.Text);
   numSession := GeraNumeroSessao;
   aux := EnviarDadosVenda(numSession,codAtivacao.Text, str.Text);

   Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  str : TStringList;
begin

if codAtivacao.Text = '' then
  begin
     MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
     codAtivacao.SetFocus;
     exit;
  end;

  if xmlCancelamento.Text = '' then
  begin
    MessageDlg('Selecione o xml de cancelamento',mtError,[mbOK],0);
    xmlCancelamento.SetFocus;
    exit;
  end;

  aux := InputBox('Chave de cancelamento','Informe a chave de cancelamento','');

  if Length(aux) <> 47 then
    begin
      MessageDlg('Chave de cancelamento inv�lida. Verifique se a mesma possui 47 caracteres',mtError,[mbOK],0);
      exit;
    end;

   str := TStringList.Create;
   str.LoadFromFile(xmlCancelamento.Text);
   numSession := GeraNumeroSessao;
   aux := CancelarUltimaVenda(numSession,codAtivacao.Text, aux, str.Text);

   Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));

end;

procedure TForm1.Button5Click(Sender: TObject);
var
  dados:string;

begin
  if codAtivacao.Text = '' then
  begin
     MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
     codAtivacao.SetFocus;
     exit;
  end;

  dados:='<CFe><infCFe versaoDadosEnt="0.07"><ide><CNPJ>'
        +cnpjSH.Text + '</CNPJ><signAC>' + AssinaturaAC.Text + '</signAC>'
        +'<numeroCaixa>001</numeroCaixa></ide><emit><CNPJ>' + cnpjContri.Text
        +'</CNPJ><IE>111111111111</IE><IM>111111</IM><indRatISSQN>N</indRatISSQN>'
        +'</emit><dest/><det nItem="1"><prod><cProd>00000000000017</cProd>'
        +'<cEAN>00000000000017</cEAN><xProd>Produto teste</xProd><CFOP>5102</CFOP>'
        +'<uCom>KG</uCom><qCom>1.0000</qCom><vUnCom>1.00</vUnCom><indRegra>A</indRegra>'
        +'<obsFiscoDet xCampoDet="xCampoDet"><xTextoDet>xTextoDet</xTextoDet></obsFiscoDet>'
        +'</prod><imposto><vItem12741>0.30</vItem12741><ICMS><ICMS00><Orig>0</Orig><CST>00</CST>'
        +'<pICMS>7.00</pICMS></ICMS00></ICMS><PIS><PISNT><CST>04</CST></PISNT></PIS><COFINS>'
        +'<COFINSNT><CST>04</CST></COFINSNT></COFINS></imposto></det><total><vCFeLei12741>0.30</vCFeLei12741>'
        +'</total><pgto><MP><cMP>01</cMP><vMP>1.00</vMP></MP></pgto><infAdic><infCpl>Obrigado e volte sempre'
        +'</infCpl></infAdic></infCFe></CFe>';

  numSession := GeraNumeroSessao;
  aux := TesteFimAFim(numSession,codAtivacao.Text,dados);
  Retorno.Text := StringReplace(aux,'|',#13#10,[rfReplaceAll]);

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  aux2 : string;
  option : Integer;
  aux3 : string;

begin
  if codAtivacao.Text = '' then
  begin
     MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
     codAtivacao.SetFocus;
     exit;
  end;

  aux := inputBox('Sele��o do tipo de codigo', 'Digite 1 para usar o c�digo de ativa��o ou 2 para usar o c�digo de emerg�ncia','1');


  if (aux <> '1') and (aux <> '2') then
  begin
    MessageDlg('Op��o inv�lida.'+ aux,mtError,[mbOK],0);
    exit;
  end;

  option := StrToInt(aux);

  if option = 2 then
    aux3 := InputBox('Codigo de emerg�ncia','Informe o codigo de emerg�ncia','')
  else
    aux3 := codAtivacao.Text;

  aux := InputBox('Codigo de ativa��o', 'Digite o novo codigo de ativa��o','');
  aux2 := InputBox('Confirma��o','confirme o novo codigo de ativa��o','');

  numSession := GeraNumeroSessao;
  aux := TrocarCodigoDeAtivacao(numSession, aux3, option, aux, aux2);
  Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  aux := ConsultarNumeroSessao(GeraNumeroSessao,codAtivacao.Text,numSession);
  Retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  ConfigurarRede.Form2.Show;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin

  if codAtivacao.Text = '' then
  begin
     MessageDlg('Digite o codigo de ativa��o',mtError,[mbOK],0);
     codAtivacao.SetFocus;
     exit;
  end;

  if AssinaturaAC.Text = '' then
  begin
     MessageDlg('Digite a assinatura ',mtError,[mbOK],0);
     AssinaturaAC.SetFocus;
     exit;
  end;

  aux := '16716114000172' + cnpjContri.Text;
  numSession := GeraNumeroSessao;
  aux := AssociarAssinatura(numSession,codAtivacao.Text, aux, AssinaturaAC.Text);

  retorno.Text := Utf8ToAnsi(StringReplace(aux,'|',#13#10,[rfReplaceAll]));

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 Self.Top := 0;
 Self.Left := 0;
end;

end.
