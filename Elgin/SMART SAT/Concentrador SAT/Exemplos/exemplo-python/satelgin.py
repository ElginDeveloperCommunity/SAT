# EDC_Tool.exe clone for linux
# Gabriel Franzeri - gabriel.franzeri@elgin.com.br 
# 19/08/2022

import ctypes
import platform

if platform.system() == "Windows":
  try:
    ffi = ctypes.WinDLL("./CSMClient.dll")
  except FileNotFoundError:
    ffi = ctypes.WinDLL("C:/dllsat.dll")
else:
  try:
    ffi = ctypes.cdll.LoadLibrary("/usr/include/satelgin/libdllsat.so")
  except OSError:
    try:
        ffi = ctypes.cdll.LoadLibrary("/usr/lib/x86_64-linux-gnu/libdllsat.so")
    except OSError:
        ffi = ctypes.cdll.LoadLibrary("./libdllsat.so")

def desabilitar_conexao_continua():
  fn = ffi.DesabilitarConexaoContinua
  fn.restype = None
  fn.argtypes = []

  return fn()

def ListAvailableSatAsJson():
  fn = ffi.ListAvailableSatAsJson
  fn.restype = ctypes.c_char_p
  fn.argtypes = []

  return fn().decode("utf-8")

def habilitar_conexao_continua():
  fn = ffi.HabilitarConexaoContinua
  fn.restype = None
  fn.argtypes = []

  return fn()

def filtra_sat_num_serie(serial):
  fn = ffi.FiltraSATNumSerie
  fn.restype = ctypes.c_int
  fn.argtypes = [ctypes.c_char_p]

  serial = ctypes.c_char_p(bytes(serial, "utf-8"))

  return int(fn(serial))

def filtra_sat_usb(bus, port):
  fn = ffi.FiltraSATUsb
  fn.restype = ctypes.c_int
  fn.argtypes = [ctypes.c_uint, ctypes.c_uint]

  bus = ctypes.c_uint(bus)
  port = ctypes.c_uint(port)

  return int(fn(bus, port))

def limpa_filtros_sat():
  fn = ffi.LimpaFiltrosSAT
  fn.restype = None
  fn.argtypes = []

  return fn()

def associar_assinatura(session_number, activation_code, cnpj_set, sign_ac):
  fn = ffi.AssociarAssinatura
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  cnpj_set = ctypes.c_char_p(bytes(cnpj_set, "utf-8"))
  sign_ac = ctypes.c_char_p(bytes(sign_ac, "utf-8"))

  return fn(session_number, activation_code, cnpj_set, sign_ac).decode("utf-8")

def ativar_sat(session_number, certification_type, activation_code, cnpj, c_uf):
  fn = ffi.AtivarSAT
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  certification_type = ctypes.c_int(certification_type)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  cnpj = ctypes.c_char_p(bytes(cnpj, "utf-8"))
  c_uf = ctypes.c_char_p(bytes(c_uf, "utf-8"))

  return fn(session_number, certification_type, activation_code, cnpj, c_uf).decode("utf-8")

def atualizar_software_sat(session_number, activation_code):
  fn = ffi.AtualizarSoftwareSAT
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def bloquear_sat(session_number, activation_code):
  fn = ffi.BloquearSAT
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def cancelar_ultima_venda(session_number, activation_code, key, cancellation_data):
  fn = ffi.CancelarUltimaVenda
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  key = ctypes.c_char_p(bytes(key, "utf-8"))
  cancellation_data = ctypes.c_char_p(bytes(cancellation_data, "utf-8"))

  return fn(session_number, activation_code, key, cancellation_data).decode("utf-8")

def comunicar_certificado_icpbrasil(session_number, activation_code, transaction_data):
  fn = ffi.ComunicarCertificadoICPBRASIL
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  transaction_data = ctypes.c_char_p(bytes(transaction_data, "utf-8"))

  return fn(session_number, activation_code, transaction_data).decode("utf-8")

def configurar_interface_de_rede(session_number, activation_code, config_rede):
  fn = ffi.ConfigurarInterfaceDeRede
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  config_rede = ctypes.c_char_p(bytes(config_rede, "utf-8"))

  return fn(session_number, activation_code, config_rede).decode("utf-8")

def consultar_numero_sessao(session_number, activation_code, consult):
  fn = ffi.ConsultarNumeroSessao
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_int]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  consult = ctypes.c_int(consult)

  return fn(session_number, activation_code, consult).decode("utf-8")

def consultar_sat(session_number):
  fn = ffi.ConsultarSAT
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int]

  session_number = ctypes.c_int(session_number)

  return fn(session_number).decode("utf-8")

def consultar_status_operacional(session_number, activation_code):
  fn = ffi.ConsultarStatusOperacional
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]
  fn.restype = ctypes.c_char_p

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def consultar_ultima_sessao_fiscal(session_number, activation_code):
  fn = ffi.ConsultarUltimaSessaoFiscal
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def desbloquear_sat(session_number, activation_code):
  fn = ffi.DesbloquearSAT
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def enviar_dados_venda(session_number, activation_code, transaction_data):
  fn = ffi.EnviarDadosVenda
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  transaction_data = ctypes.c_char_p(bytes(transaction_data, "utf-8"))

  return fn(session_number, activation_code, transaction_data).decode("utf-8")

def extrair_logs(session_number, activation_code):
  fn = ffi.ExtrairLogs
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p]
  fn.restype = ctypes.c_char_p

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))

  return fn(session_number, activation_code).decode("utf-8")

def gera_numero_sessao():
  return int(ffi.GeraNumeroSessao())

def teste_fim_a_fim(session_number, activation_code, transaction_data):
  fn = ffi.TesteFimAFim
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  transaction_data = ctypes.c_char_p(bytes(transaction_data, "utf-8"))

  return fn(session_number, activation_code, transaction_data).decode("utf-8")

def trocar_codigo_de_ativacao(session_number, activation_code, option, new_code, new_code_confirmation):
  fn = ffi.TrocarCodigoDeAtivacao
  fn.restype = ctypes.c_char_p
  fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_int, ctypes.c_char_p, ctypes.c_char_p]

  session_number = ctypes.c_int(session_number)
  activation_code = ctypes.c_char_p(bytes(activation_code, "utf-8"))
  option = ctypes.c_int(option)
  new_code = ctypes.c_char_p(bytes(new_code, "utf-8"))
  new_code_confirmation = ctypes.c_char_p(bytes(new_code_confirmation, "utf-8"))

  return fn(session_number, activation_code, option, new_code, new_code_confirmation).decode("utf-8")

def sat_log_variaveis():
  fn = ffi.sat_log_variaveis
  fn.restype = ctypes.c_char_p
  fn.argtypes = []

  return fn().decode("utf-8")

def versao_lib():
  fn = ffi.VersaoLib
  fn.restype = ctypes.c_char_p
  fn.argtypes = []

  return fn().decode("utf-8")
