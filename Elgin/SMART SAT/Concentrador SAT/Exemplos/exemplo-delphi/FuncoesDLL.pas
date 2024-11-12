
unit FuncoesDLL;

interface
  function ConsultarSAT(numSessao : Integer):Pansichar ; stdcall ; external 'CSMClient.dll';
  function ConsultarStatusOperacional(numSessao : Integer ; codAtivacao : AnsiString):Pansichar ; stdcall ; external 'CSMClient.dll';
  function EnviarDadosVenda(numSessao : Integer ; codAtivacao : AnsiString ; dadosVenda : AnsiString):Pansichar ; stdcall ; external 'CSMClient.dll';
  function CancelarUltimaVenda(numSessao : Integer ;  codAtivacao : AnsiString ; chaveCanc : AnsiString ; dadosCanc : AnsiString):Pansichar ; stdcall ; external 'CSMClient.dll';

  function TesteFimAFim(numSessao : Integer ; codAtivacao : AnsiString ; dadosVenda : AnsiString):Pansichar ; stdcall ; external 'CSMClient.dll';
  function TrocarCodigoDeAtivacao(numSessao : Integer ; codAtivacao : AnsiString ; opcao : Integer ; newCod : AnsiString ; confCod : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function ConsultarNumeroSessao(numSessao : Integer ; codAtivacao : AnsiString ; numConsulta : Integer):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function AssociarAssinatura(numSessao : Integer ; codAtivacao : AnsiString ; cnpj : AnsiString ; assCNPJ : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function AtualizarSoftwareSAT(numSessao : Integer ; codAtivacao : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function BloquearSAT(numSessao : Integer ; codAtivacao : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function DesbloquearSAT(numSessao : Integer ; codAtivacao : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function Base64ToAscii():PAnsiChar;stdcall;external 'CSMClient.dll';
  function ExtrairLogs(numSessao : Integer ; codAtivacao : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function ConfigurarInterfaceDeRede(numSessao : Integer ; codAtivacao : AnsiString ; conf : AnsiString):PAnsiChar ; stdcall ; external 'CSMClient.dll';
  function AtivarSAT(numSessao : Integer; tpCertificado : Integer ; codAtivacao : AnsiString; cnpjCont : AnsiString ; codEstado : Integer):PAnsiChar ; stdcall ; external'CSMClient.dll';
implementation

end.
