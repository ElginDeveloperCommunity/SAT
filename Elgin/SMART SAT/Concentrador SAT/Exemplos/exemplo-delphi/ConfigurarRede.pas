unit ConfigurarRede;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FuncoesDLL;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Button1: TButton;
    Label13: TLabel;
    Edit10: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

  function GeraNumeroSessao() : Integer ;
  var
    myfile:TextFile;
    text:string;
    sessao :  Integer;
  begin
    AssignFile(myFile, 'NumeroSessao.txt');
    // Reopen the file for reading
   Reset(myFile);

   // Display the file contents
   while not Eof(myFile)do
   begin
     ReadLn(myFile, text);
     sessao := StrToInt(text);
   end;

   // Close the file for the last time
   CloseFile(myFile);


   ReWrite(myFile);
   // Write a couple of well known words to this file
   WriteLn(myFile, IntToStr(sessao+1));
   // Close the file
   CloseFile(myFile);

  end;

procedure TForm2.Button1Click(Sender: TObject);
var
  dados,aux : string;
begin

  if Edit10.Text = '' then
  begin
    MessageDlg('Digite o codigo de ativação',mtError,[mbOK],0);
    exit;
  end;

  dados := '<?xml version="1.0" encoding="UTF-8"?><config>'
  +'<tipoInter>ETHE</tipoInter>';

  case ComboBox1.ItemIndex of
    0:begin
    if Edit1.Text = '' then
     begin
      MessageDlg('Digite o IP',mtError,[mbOK],0);
      exit;
     end;

     if Edit2.Text = '' then
     begin
      MessageDlg('Digite a máscara de rede',mtError,[mbOK],0);
      exit;
     end;

     if Edit3.Text = '' then
     begin
      MessageDlg('Digite o gateway',mtError,[mbOK],0);
      exit;
     end;

     if Edit4.Text = '' then
     begin
      MessageDlg('Digite o DNS primário',mtError,[mbOK],0);
      exit;
     end;

     if Edit5.Text = '' then
     begin
      MessageDlg('Digite o DNS secundário',mtError,[mbOK],0);
      exit;
     end;

     dados := dados + '<tipoLan>IPFIX</tipoLan>'
                    + '<lanIP>' + Edit1.Text + '</lanIP>'
                    + '<lanMask>' + Edit2.Text + '</lanMask>'
                    + '<lanGW>' + Edit3.Text + '</lanGW>'
                    + '<lanDNS1>' + Edit4.Text + '</lanDNS1>'
                    + '<lanDNS2>' + Edit5.Text + '</lanDNS2>'
                    + '</config>';

    end;
    1:begin
      dados := dados + '<tipoLan>DHCP</tipoLan>'
                   + '</config>';
  end;
 end;

   aux := ConfigurarInterfaceDeRede(GeraNumeroSessao, Edit10.text, dados);
   MessageDlg(StringReplace(aux,'|',#13#10,[rfReplaceAll]),mtInformation,[mbOK],0);
end;

end.
