package com.elgin.csmtest;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.elgin.wrapper_csm_client.SAT;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    private Button button, button2, button3;
    private EditText edt_codatv;
    private TextView txt_ret;
    private SAT s;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        s = new SAT();

        // no caso de ter múltiplos SATs/MFes conectados à Raspberry Pi, será necessário adicionar
        // ao objecto usado o número de série do SATs com o qual se deseja comunicar.
        // s.InformaNumeroSerieSAT("0000000");

        String test = s.ConsultarSAT(geraNumeroSessao());
        Toast.makeText(getApplicationContext(), "Resultado comunicação com SAT:" + test, Toast.LENGTH_LONG).show();

        button = findViewById(R.id.button);
        button2 = findViewById(R.id.button2);
        button3 = findViewById(R.id.button3);
        edt_codatv = findViewById(R.id.edt_codatv);
        txt_ret = findViewById(R.id.txt_ret);

        button.setOnClickListener(view -> {
            consultarSAT();
        });

        button2.setOnClickListener(view -> {
            consultarStatusOperacional();
        });

        button3.setOnClickListener(view -> {
            enviarVenda();
        });


    }
    private int geraNumeroSessao(){
        return new Random().nextInt((999999 - 1) + 1) + 1;
    }

    private void consultarSAT() {

        String r = s.ConsultarSAT(geraNumeroSessao());
        txt_ret.setText(r);
    }

    private void consultarStatusOperacional(){
        String r = s.ConsultarStatusOperacional(geraNumeroSessao(), edt_codatv.getText().toString());
        txt_ret.setText(r);
    }

    private void enviarVenda(){
        String dados = "<CFe><infCFe versaoDadosEnt=\"0.08\"><ide><CNPJ>16716114000172</CNPJ><signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC><numeroCaixa>123</numeroCaixa></ide><emit><CNPJ>14200166000166</CNPJ><IE>111111111111</IE><IM>123123</IM><indRatISSQN>N</indRatISSQN></emit><dest><CNPJ>16716114000172</CNPJ><xNome>Destinatario</xNome></dest><det nItem=\"1\"><prod><cProd>0001</cProd><cEAN>0012345678905</cEAN><xProd>Trib ICMS Integral Aliquota 10.00% - PIS e COFINS cod 04 - Orig 0</xProd><NCM>47061000</NCM><CFOP>5001</CFOP><uCom>kg</uCom><qCom>1.0000</qCom><vUnCom>100.00</vUnCom><indRegra>A</indRegra></prod><imposto><vItem12741>1.00</vItem12741><ICMS><ICMS00><Orig>0</Orig><CST>00</CST><pICMS>10.00</pICMS></ICMS00></ICMS><PIS><PISNT><CST>04</CST></PISNT></PIS><COFINS><COFINSNT><CST>04</CST></COFINSNT></COFINS></imposto></det><total/><pgto><MP><cMP>01</cMP><vMP>100.00</vMP></MP></pgto></infCFe></CFe>";
        String r = s.EnviarDadosVenda(geraNumeroSessao(), edt_codatv.getText().toString(), dados);
        txt_ret.setText(r);
    }
}