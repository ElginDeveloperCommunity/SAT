unit Unit2;

interface

  Function AbreCupomCancelamento(path_file:AnsiString; chCanc:AnsiString; CNPJ:AnsiString; signAC:AnsiString; numeroCaixa:Integer): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'
  Function FechaCupomCancelamento(path_file:AnsiString; codigoAtivacaoSAT:AnsiString):PAnsiChar; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function AbreCupomVenda(path_file : AnsiString;
                          versaoDadosEnt : AnsiString;
                          CNPJ_SH : AnsiString;
                          signAC : AnsiString;
                          numeroCaixa : Integer;
                          CNPJ_emit : AnsiString;
                          IE : AnsiString;
                          IM : AnsiString;
                          cRegTribISSQN : AnsiString;
                          indRatISSQN : AnsiString;
                          CNPJ_dest : AnsiString;
                          CPF_dest : AnsiString;
                          xNome_dest: AnsiString ): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function InformaProduto(path_file : AnsiString;
                          cProd : AnsiString;
                          cEAN : AnsiString;
                          xProd : AnsiString;
                          NCM : AnsiString;
                          CEST : AnsiString;
                          CFOP : AnsiString;
                          uCom : AnsiString;
                          qCom : AnsiString;
                          vUnCom : AnsiString;
                          indRegra : AnsiString;
                          vDesc : AnsiString;
                          vOutro : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function  InformaImposto(path_file : AnsiString;
                           nItem:Integer;
                           vItem12741 : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function  InformaICMS40(path_file : AnsiString;
                          nItem : Integer;
                          Orig : Integer;
                          CST : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function InformaPISNT(path_file : AnsiString;
                        nItem : Integer;
                        CST : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function InformaCOFINSNT(path_file : AnsiString;
                           nItem : Integer;
                           CST : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'


  Function InformaTotal(path_file : AnsiString;
                        vDescSubtot : AnsiString;
                        vAcresSubtot : AnsiString;
                        vCFeLei12741  : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function InformaPgto(path_file : AnsiString;
                       cMP : AnsiString;
                       vMP : AnsiString;
                       cAdmC : AnsiString): Integer; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

  Function FechaCupomVenda(path_file:AnsiString; codigoAtivacaoSAT:AnsiString):PAnsiChar; stdcall; external 'D:\Documentos\Projetos\QT_Projetos\integrado\e1_sat-v01.00.01\compile\x86\debug\E1_SAT01.dll'

implementation

end.
