program Project1;

uses
  Vcl.Forms,
  Home in 'Home.pas' {Form1},
  FuncoesDLL in 'FuncoesDLL.pas',
  ConfigurarRede in 'ConfigurarRede.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
