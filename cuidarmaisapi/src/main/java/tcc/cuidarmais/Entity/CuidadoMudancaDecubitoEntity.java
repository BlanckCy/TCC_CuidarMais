package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_mudancadecubito")
public class CuidadoMudancaDecubitoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidadoMudancadecubito;
    private String mudanca;
    private String hora;
    private String data_hora;
    private int idpaciente;
    private int idrotina;
    
    public int getIdrotina() {
        return idrotina;
    }
    public void setIdrotina(int idrotina) {
        this.idrotina = idrotina;
    }
    public int getIdcuidadoMudancadecubito() {
        return idcuidadoMudancadecubito;
    }
    public void setIdcuidadoMudancadecubito(int idcuidadoMudancadecubito) {
        this.idcuidadoMudancadecubito = idcuidadoMudancadecubito;
    }
    public String getMudanca() {
        return mudanca;
    }
    public void setMudanca(String mudanca) {
        this.mudanca = mudanca;
    }
    public String getHora() {
        return hora;
    }
    public void setHora(String hora) {
        this.hora = hora;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
    public String getData_hora() {
        return data_hora;
    }
    public void setData_hora(String data_hora) {
        this.data_hora = data_hora;
    }    
    
}
