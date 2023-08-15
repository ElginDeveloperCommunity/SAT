# Concentrador Sat e Mfe

[Funcionamento](#funcionamento)
[Instalação Server](#instalacao-server)
[Instalação Client Android](#android)

Para baixar essa pasta completa com documentação, server e bibliotecas de client, baixar esse [arquivo](./Concentrador_SAT.zip).

# Funcionamento

A Raspberry Pi e a Aplicação da Automação Comercial devem estar na mesma rede. Na aplicação serão feitas as chamadas à biblioteca seguindo a especificação do SAT presente na [documentação](https://elgindevelopercommunity.github.io/group__g2.html). 
A biblioteca vai então comunicar com a Raspberry Pi que irá comunicar com o SAT conectado.
<br>
É possível conectar mais que um SAT à Raspberry Pi, nesse caso, o próprio CSMServer irá gerenciar com qual SAT comunicar, ou então pode-se especificar na chamada da biblioteca o número de série do SAT com qual se prefere comunicar. 
<br>
A seguir um figura que representa a arquitetura do projeto com Concentrador SAT.

<br>

![image](https://github.com/ElginDeveloperCommunity/SAT/assets/78883867/9d7193a9-4343-44ed-bcbd-451e2a02f1be)

<br>


### Requisitos
* SAT: Equipamento deve ser **Elgin**
* Client: Biblioteca Android
* Sistema operacional da Raspberry Pi: deve possuir a `glibc ^2.28` (ex: S.O. padrão disponível no [Raspberry Pi Imager](https://www.raspberrypi.com/software/))
* Acesso à Raspberry Pi para instalação do Server
* Aplicação da Automação Comercial na mesma rede que a Raspberry Pi com o software do concentrador

### Observações
* Este projeto depende da glibc 2.28 ou mais. Essa versão da glibc está presente no Debian 11 (bullseye), portanto aconselhável instalar um sistema operacional que possua essa lib, como por exemplo, o sistema operacional padrão da Raspberry Pi.

# Instalação Server
Para instalar o Server é necessário transferir o arquivo [InstaladorCSM.tag.gz](./Server/) para a Raspberry Pi.
Por exemplo, tendo configurado a conexão via ssh com sua Raspberry Pi, pode ser usado o Secure Copy Protocol. 

```bash
$ scp ./InstaladorCSM.tar.gz user@raspberrypi.local:.
```

e então acessar a Raspberry Pi 

```bash
$ ssh user@raspberrypi.local
```

Descompactar o arquivo e então instalar o Server usando o script.

```bash
$ tar -zxvf InstaladorCSM.tar.gz
$ cd Instalador_CSM
$ sudo ./installCSMServer
```

Pronto, o server do Concentrador está instalado. 

### Comandos adicionais

Para verificar o status do serviço:
```bash
$ systemctl status CSMServer.service
```

Restartando serviço
```bash
$ systemctl restart CSMServer.service
```
	
Parando serviço 
```bash
$ systemctl stop CSMServer.service
```
	
Desinstalando CSMServer
```bash
$ sudo ./uninstallCSMServer
```

Para ver logs em tempo real do server, é necessário primeiro ativar os logs no arquivo `/opt/CSMServer/configParametros.json`:
```json
{
    "debugLog"      : true,
    "portaServer"   : 2701,
    "portaBroadcast": 3000
}
```

restartar o serviço e então executar o comando:
```bash
$ tail -f /opt/CSMServer/logCSM.txt
```

### Arquivos de Log

Os logs serão salvos no arquivo logCSM.txt até que ele chegue a 100Mb. Quando chegar a 100Mb ele será renomeado para logCSM.bkp e os logs mais recentes serão salvos em um novo logCSM.txt. Dessa maneira, os logs mais recentes sempre estarão no arquivo `logCSM.txt` e serão guardados na raspberry até 200Mb de logs dividos entre os arquivos logCSM.txt e logCSM.bkp.


# Instalação Client

## Android

Utilizar a [biblioteca](./Client/Android/wrapper_csm_client-v01.00.03-release.aar) para Android no seu projeto. Essa biblioteca segue a especificação do SAT. A documentação está presente [nesse link](https://elgindevelopercommunity.github.io/group__g2.html).

### Configurações do App
Permissões necessárias a ser adicionado no AndroidManifest.xml

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

<hr>

Configurações do Gradle
```gradle
dependencies {
    implementation files ('libs/wrapper_csm_client-v01.00.03-release.aar')
    // outras dependencies...
}
```

### Exemplo de Uso

```java
import ...
import com.elgin.wrapper_csm_client.SAT;

...

@Override
protected void onCreate(Bundle savedInstanceState) {
        ...
        SAT s = new SAT();

        String testConsultaSAT = s.ConsultarSAT("123456");
        Toast.makeText(getApplicationContext(), "Resultado Comunicação com SAT: " + test, Toast.LENGTH_LONG).show();
    }
```

Um exemplo mais completo está presente em [aqui](./Exemplos/Exemplo_Android/app/src/main/java/com/elgin/csmtest/MainActivity.java).
