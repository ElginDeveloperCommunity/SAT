#!/usr/bin/env python

import sys
import os.path
import satelgin as sat
from rich.theme import Theme
from rich.table import Table
from rich.console import Console 
from rich.markdown import Markdown
from configparser import ConfigParser

CONFIG_FILE = 'config_edc.ini'

custom_theme = Theme({'success':'green', 'error':'bold red'})
console = Console(theme=custom_theme)

def main():
    boas_vindas()
    choice = ''
    while choice != '13':
        main_table = Table(title = '*** EDC TOOLS ***')
        main_table.add_column('Comando', style='magenta')
        main_table.add_column('Função', style='green')
        main_table.add_row('0)', 'Configurações Gerais')
        main_table.add_row('1)', 'Consultar SAT')
        main_table.add_row('2)', 'Status Operacional')
        main_table.add_row('3)', 'Efetuar Venda')
        main_table.add_row('4)', 'Cancelar Venda')
        main_table.add_row('5)', 'Teste Fim A Fim')
        main_table.add_row('6)', 'Trocar Código de Ativação (não implementado)')
        main_table.add_row('7)', 'Consultar Número de Sessão ')
        main_table.add_row('8)', 'Atualizar Software ')
        main_table.add_row('9)', 'Extrair Log ')
        main_table.add_row('10)', 'Bloquear Sat ')
        main_table.add_row('11)', 'Desbloquear Sat ')
        main_table.add_row('12)', 'Ativar Sat')
        main_table.add_row('13)', 'Sair')
        console.print(main_table)
        
        choice = input()
        
        if choice == '0':
            c = ''
            while c != '5':
                conf_table = Table(title = 'Configurações')
                conf_table.add_column('Comando', style='magenta')
                conf_table.add_column('Função', style='green')
                conf_table.add_row('1)', 'Configurar Código de Ativação') 
                conf_table.add_row('2)', 'Configurar CNPJ Software House') 
                conf_table.add_row('3)', 'Configurar CNPJ Contribuinte') 
                conf_table.add_row('4)', 'Configurar Assinatura Automação Comercial') 
                conf_table.add_row('5)', 'Sair') 
                console.print(conf_table)
                c = input()
                if c == '1':
                    cod_ativacao = input('Digite o Código de Ativação: ')
                    set_config_key('userinfo', 'cod_ativacao', cod_ativacao)
                elif c == '2':
                    cnpjSH = input('Digita o CNPJ da Software House: ')
                    set_config_key('userinfo', 'cnpjSH', cnpjSH)
                elif c == '3':
                    cnpjContri = input('Digita o CNPJ do Contribuinte: ')
                    set_config_key('userinfo', 'cnpjContri', cnpjContri)
                elif c == '4':
                    assinatura_ac = input('Digita a Assinatura da Automação COmercial: ')
                    set_config_key('userinfo', 'assinatura_ac', assinatura_ac)
                else:
                    if c != '5':
                        print('\nEscolher uma opção válida\n')

        elif choice == '1':
            consultar_sat()
        elif choice == '2':
            consultar_status(get_cod_ativacao())
        elif choice == '3':
            enviar_dados_venda(get_cod_ativacao())
        elif choice == '4':
            xml_cancelamento(get_cod_ativacao())
        elif choice == '5':
            teste_fim_a_fim(get_cod_ativacao())
        elif choice == '6':
            trocar_codigo_ativacao(get_cod_ativacao())
        elif choice == '7': 
            consultar_numero_sessao(get_cod_ativacao())
        elif choice == '8':
            atualizar_software(get_cod_ativacao())
        elif choice == '9':
            extrair_logs(get_cod_ativacao())
        elif choice == '10':
            bloquear_sat(get_cod_ativacao())
        elif choice == '11':
            desbloquear_sat(get_cod_ativacao())
        elif choice == '12':
            ativar_sat(get_cod_ativacao())
        else:
            if choice != '13':
                print('\nEscolher uma opção válida\n')

def gerar_numero_sessao():
    return sat.gera_numero_sessao()

def get_cod_ativacao():
    val = get_config_key('userinfo', 'cod_ativacao')
    if val != '':
        return val
    cod_ativacao = ''
    while cod_ativacao == '':
        cod_ativacao = input('Digite o código de ativação\n') 
    return cod_ativacao

def get_cnpj_sh():
    val = get_config_key('userinfo', 'cnpjSH')
    if val != '':
        return val
    cnpj_sh = ''
    while cnpj_sh == '':
        cnpj_sh = input('CNPJ Software House: ')
    return cnpj_sh

def get_cnpj_contri():
    val = get_config_key('userinfo', 'cnpjContri')
    if val != '':
        return val
    cnpj_contri = ''
    while cnpj_contri == '':
        cnpj_contri = input('CNPJ Contribuinte: ')
    return cnpj_contri

def get_assinatura():
    val = get_config_key('userinfo', 'assinatura_ac')
    if val != '':
        return val
    assinatura = ''
    while assinatura == '':
        assinatura = input('Assinatura: ')
    return assinatura

def atualizar_software(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.atualizar_software_sat(num_sessao, cod_ativacao)          
    print_terminal(ret)

def extrair_logs(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.extrair_logs(num_sessao, cod_ativacao)
    print_terminal('Logs: ' + ret)
    
def bloquear_sat(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.bloquear_sat(num_sessao, cod_ativacao)
    print_terminal(ret)

def desbloquear_sat(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.desbloquear_sat(num_sessao, cod_ativacao)
    print_terminal(ret)

def ativar_sat(cod_ativacao):
    uf = get_uf()
    while uf != '35' and uf != '23':
        print_terminal('Única opção disponível no momento é 35')
        uf = get_uf()
    cnpj = ('Digitar o CNPJ :\n')
    num_sessao = gerar_numero_sessao()
    ret = sat.ativar_sat(num_sessao, 1, cod_ativacao, cnpj, uf)
    print_terminal(ret)

def consultar_sat():
    num_sessao = gerar_numero_sessao()
    ret = sat.consultar_sat(num_sessao)
    print_terminal(ret)

def consultar_status(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.consultar_status_operacional(num_sessao, cod_ativacao)
    print_terminal(ret)

def enviar_dados_venda(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    filename = 'arquivoVenda.xml'
    file = check_file_exists(filename)    
    if file:
        t = open(filename, 'r')
        data = t.read().replace('\n', '')
        t.close()
        ret = sat.enviar_dados_venda(num_sessao, cod_ativacao, data)
        print_terminal(ret)
    else:
        ret = sat.enviar_dados_venda(num_sessao, cod_ativacao, '<?xml version=\"1.0\"?> <CFe> <infCFe versaoDadosEnt=\"0.07\"> <ide><CNPJ>16716114000172</CNPJ><signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC><numeroCaixa>001</numeroCaixa> </ide><emit><CNPJ>14200166000166</CNPJ><IE>111111111111</IE><indRatISSQN>N</indRatISSQN></emit><dest></dest><det nItem=\"1\"> <prod> <cProd>00000000000001</cProd> <xProd>PRODUTO NFCE 1</xProd> <NCM>94034000</NCM> <CFOP>5102</CFOP> <uCom>UN</uCom> <qCom>1.0000</qCom> <vUnCom>3.51</vUnCom> <indRegra>T</indRegra> </prod> <imposto> <ICMS><ICMS00><Orig>0</Orig><CST>00</CST><pICMS>7.00</pICMS></ICMS00> </ICMS><PIS><PISAliq><CST>01</CST><vBC>6.51</vBC><pPIS>0.0165</pPIS></PISAliq> </PIS> <COFINS><COFINSAliq><CST>01</CST><vBC>6.51</vBC><pCOFINS>0.0760</pCOFINS></COFINSAliq> </COFINS> </imposto> </det> <total><DescAcrEntr><vDescSubtot>0.51</vDescSubtot></DescAcrEntr><vCFeLei12741>0.56</vCFeLei12741></total><pgto> <MP> <cMP>01</cMP> <vMP>6.51</vMP> </MP></pgto><infAdic> <infCpl>Trib aprox R$ 0,36 federal, R$ 1,24 estadual e R$ 0,00 municipal&lt;br&gt;CAIXA: 001 OPERADOR: ROOT</infCpl></infAdic></infCFe></CFe>')
        print_terminal(ret)

def xml_cancelamento(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    filename = 'arquivoCancelamento.xml'
    file = check_file_exists(filename)    
    chave = get_chave_cancelamento();
    if file:
        t = open(filename, 'r')
        data = t.read().replace('\n', '')
        t.close()
        ret = sat.cancelar_ultima_venda(num_sessao, cod_ativacao, chave, data)
        print_terminal(ret)
    else:
        ret = sat.cancelar_ultima_venda(num_sessao, cod_ativacao, chave, '<CFeCanc><infCFe chCanc=\"CFe13181114200166000166599000162500104927318337\"><ide><CNPJ>16716114000172</CNPJ><signAC>MD2Nof/O0tQMPKiYeeAydSjYt7YV9kU0nWKZGXHVdYIzR2W9Z6tgXni/Y5bnjmUAk8MkqlBJIiOOIskKCjJ086k7vAP0EU5cBRYj/nzHUiRdu9AVD7WRfVs00BDyb5fsnnKg7gAXXH6SBgCxG9yjAkxJ0l2E2idsWBAJ5peQEBZqtHytRUC+FLaSfd3+66QNxIBlDwQIRzUGPaU6fvErVDSfMUf8WpkwnPz36fCQnyLypqe/5mbox9pt3RCbbXcYqnR/4poYGr9M9Kymj4/PyX9xGeiXwbgzOOHNIU5M/aAs0rulXz948bZla0eXABgEcp6mDkTzweLPZTbmOhX+eA==</signAC><numeroCaixa>001</numeroCaixa></ide><emit/><dest></dest><total/></infCFe></CFeCanc>')
        print_terminal(ret)

def teste_fim_a_fim(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    cnpjSH = get_cnpj_sh()
    cnpjContri = get_cnpj_contri()
    AssinaturaAC = get_assinatura()
    dados = ' <CFe><infCFe versaoDadosEnt="0.07"><ide><CNPJ>' + cnpjSH + '</CNPJ><signAC>' + AssinaturaAC + '</signAC> <numeroCaixa>001</numeroCaixa></ide><emit><CNPJ>' + cnpjContri + '</CNPJ><IE>111111111111</IE><IM>111111</IM><indRatISSQN>N</indRatISSQN> </emit><dest/><det nItem="1"><prod><cProd>00000000000017</cProd> <cEAN>00000000000017</cEAN><xProd>Produto teste</xProd><CFOP>5102</CFOP> <uCom>KG</uCom><qCom>1.0000</qCom><vUnCom>1.00</vUnCom><indRegra>A</indRegra> <obsFiscoDet xCampoDet="xCampoDet"><xTextoDet>xTextoDet</xTextoDet></obsFiscoDet> </prod><imposto><vItem12741>0.30</vItem12741><ICMS><ICMS00><Orig>0</Orig><CST>00</CST> <pICMS>7.00</pICMS></ICMS00></ICMS><PIS><PISNT><CST>04</CST></PISNT></PIS><COFINS> <COFINSNT><CST>04</CST></COFINSNT></COFINS></imposto></det><total><vCFeLei12741>0.30</vCFeLei12741> </total><pgto><MP><cMP>01</cMP><vMP>1.00</vMP></MP></pgto><infAdic><infCpl>Obrigado e volte sempre </infCpl></infAdic></infCFe></CFe>';
    ret = sat.teste_fim_a_fim(num_sessao, cod_ativacao, dados)
    print_terminal(ret)

# TODO
def trocar_codigo_ativacao(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    cod_tipo = get_tipo_codigo_ativacao()

def consultar_numero_sessao(cod_ativacao):
    num_sessao = gerar_numero_sessao()
    ret = sat.consultar_numero_sessao(num_sessao, cod_ativacao, num_sessao)
    print_terminal(ret)
    

# Utils
def get_uf():
    uf = input('Código UF\nDigite o código de área do estado onde o SAT será ativado. \nExemplo: 35 = SP / 23 = CE\nCódigo UF: ')
    return uf
     
def check_file_exists(filename):
    xml_exists = os.path.exists(filename)
    if not xml_exists:
        print_terminal(f'Coloque um {filename} no diretório atual, dados de exemplo serão usados')
    return xml_exists
    
def get_chave_cancelamento():
    chave = input('Informe a Chave de Cancelamento: ')
    while len(chave) != 47:
        chave = input('Informe a Chave de Cancelamento, com 47 caracteres: ')
    return chave

def get_tipo_codigo_ativacao():
    cod = input('Selecione o tipo de código\nDigite 1 para usar o código de ativação ou 2 para usar o código de emergência: ')
    while cod != '1' or cod != '2':
        console.print('Opção Inválida', style='error')
        cod = input('\nSelecione o tipo de código\nDigite 1 para usar o código de ativação ou 2 para usar o código de emergência: ')
    return cod

def set_config_key(section, key, value):
    config_object = ConfigParser()
    try:
        if os.path.exists(CONFIG_FILE):
            config_object.read(CONFIG_FILE)
            info = config_object['userinfo']
            # se existir, vai atualizar, se não existir , vai criar
            info[key] = value
            file = open(CONFIG_FILE, 'w')
            config_object.write(file)
            file.close()
        else:
            # cria novo arquivo de configurações
            config_object[section] = { key: value }
            file = open(CONFIG_FILE, 'w')
            config_object.write(file)
            file.close()
    except KeyError:
        # se deu erro, é porque não existe a key ainda
        console.print('essa key não existe', style='error')
    except:
        console.print('deu erro na matrix', style='error')

def get_config_key(section, key):
    config_object = ConfigParser()
    try:
        config_object.read(CONFIG_FILE)
        info = config_object[section]
        return info[key]
    except KeyError:
        return ''
    except:
        console.print('deu erro na matrix da get_config_key', style='error')
        
# UI 
def print_terminal(text: str):
    md = f'# {text}'
    mdo = Markdown(md)
    console.print(mdo, style = 'cyan')

def boas_vindas():
    console.print('''
                                                  ,----,                             ,--,              
                                                ,/   .`|  ,----..       ,----..   ,---.'|              
    ,---,.    ,---,      ,----..              ,`   .'  : /   /   \     /   /   \  |   | :   .--.--.    
  ,'  .' |  .'  .' `\   /   /   \           ;    ;     //   .     :   /   .     : :   : |  /  /    '.  
,---.'   |,---.'     \ |   :     :        .'___,/    ,'.   /   ;.  \ .   /   ;.  \|   ' : |  :  /`. /  
|   |   .'|   |  .`\  |.   |  ;. /        |    :     |.   ;   /  ` ;.   ;   /  ` ;;   ; ' ;  |  |--`   
:   :  |-,:   : |  '  |.   ; /--`         ;    |.';  ;;   |  ; \ ; |;   |  ; \ ; |'   | |_|  :  ;_     
:   |  ;/||   ' '  ;  :;   | ;            `----'  |  ||   :  | ; | '|   :  | ; | '|   | :.'\  \    `.  
|   :   .''   | ;  .  ||   : |                '   :  ;.   |  ' ' ' :.   |  ' ' ' :'   :    ;`----.   \ 
|   |  |-,|   | :  |  '.   | '___             |   |  ''   ;  \; /  |'   ;  \; /  ||   |  ./ __ \  \  | 
'   :  ;/|'   : | /  ; '   ; : .'|            '   :  | \   \  ',  /  \   \  ',  / ;   : ;  /  /`--'  / 
|   |    \|   | '` ,/  '   | '/  :            ;   |.'   ;   :    /    ;   :    /  |   ,/  '--'.     /  
|   :   .';   :  .'    |   :    /             '---'      \   \ .'      \   \ .'   '---'     `--'---'   
|   | ,'  |   ,.'       \   \ .'                          `---`         `---`                          
`----'    '---'          `---`                                                                         
                                                                                                       
    ''')
    console.print('''
   ____      _        ___              _   ___         __   
  / __/__   (_)__ _  / _ )___ __ _    | | / (_)__  ___/ /__ 
 _\ \/ -_) / / _ `/ / _  / -_)  ' \   | |/ / / _ \/ _  / _ 
/___/\__/_/ /\_,_/ /____/\__/_/_/_/   |___/_/_//_/\_,_/\___/
       |___/                                                

    ''', style = 'success')


if __name__ == '__main__':
    main()
