# ElginSATFramework

O ElginSATFramework é um pacote de solução que tem como objetivo facilitar a integração e operação de equipamentos SAT (Sistema autenticador transmissor) do estado de São Paulo.
Utilize-o para gerar seus arquivos de XML e transmiti-los para o SAT, automaticamente você poderá contar com a custódia dos seus arquivos de XML e monitoramento dos equipamentos em tempo real na plataforma Veratici!!!

Por onde começar?
=================
Faça download do arquivo `E1_SAT_Compile.rar`. Através dessa DLL você pode gerar seus arquivos de XML para o qualquer modelo de SAT do mercado usando funções de alto nivel!
A geração do XML pode ser feita para qualquer SAT de mercado e não tem nenhuma restrição de uso.

Para transmissão automática dos arquivos para o SAT utilize as funções de fechamento da DLL E1_SAT. 
Se faz necessário a criação de um arquivo `e1_conf.ini` na pasta da aplicação com a chave `caminho_biblioteca_sat` apontando para o caminho de instalação da biblioteca de comunicação com o SAT. Exemplo:
```
[configuracao_sat]
caminho_biblioteca_sat=C:\\Program Files (x86)\\sat\\satelgin 6.0.0\\lib\\dllsat.dll
```
Essa Função está disponível apenas para Equipamentos SAT Elgin e Bematech quando não estiver integrado com a plataforma Veraciti.

Para habilitar a custódia dos arquivos XML, monitorar os equipamentos SAT e ter integração com qualquer SAT de mercado usando a função de fechamento é necessário fazer integração com a plataforma veraciti. O primeiro passo para essa integração é criar uma conta na plataforma. Para isso basta solicitar ao nosso [suporte técnico](https://elginbematech.com.br/chamado/).
Com a conta criada, faça download da biblioteca Veraciti (Veraciti.rar neste repositório) e configure o arquivo e1_conf.ini com o caminho da biblioteca Veraciti.dll.
Exemplo:
```
[configuracao_sat]
caminho_biblioteca_sat=C:\\automacao\\sat\\lib\\Veraciti.dll
```
O último passo é configurar a biblioteca Veraciti para carregar a biblioteca do fabricante do SAT que será utilizado. Para isso você pode usar o aplicativo `ConfiguradorLibMonitoramento.exe` presente no pacote Veraciti.rar. Selecione a biblioteca, configure proxy caso necessário e preencha o código de ativação do SAT e ao clicar em salvar será gerado um arquivo monitorasat.xml no diretório, copie esse arquivo para a pasta da aplicação.

Documentação
=================

[Documentação](http://plataforma-e1.leonwebhost.com/group__s0.html)

Exemplos
=================

- [Delphi](https://github.com/ElginDeveloperCommunity/Exemplo_FrameworkSAT)
- [VB6](https://github.com/ElginDeveloperCommunity/Exemplo_FrameworkSAT_VB6)
