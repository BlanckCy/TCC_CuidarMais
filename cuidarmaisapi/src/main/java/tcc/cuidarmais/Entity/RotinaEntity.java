package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "rotina")
public class RotinaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idrotina;
    
    private String data_hora;
    private boolean realizado;
    private int tipo_cuidado;
    private String cuidado;
    private int idpaciente;

    public int getIdrotina() {
        return idrotina;
    }
    public void setIdrotina(int idrotina) {
        this.idrotina = idrotina;
    }
    public String getData_hora() {
        return data_hora;
    }
    public void setData_hora(String data_hora) {
        this.data_hora = data_hora;
    }
    public boolean isRealizado() {
        return realizado;
    }
    public void setRealizado(boolean realizado) {
        this.realizado = realizado;
    }
    public int getTipo_cuidado() {
        return tipo_cuidado;
    }
    public void setTipo_cuidado(int tipo_cuidado) {
        this.tipo_cuidado = tipo_cuidado;
    }
    public String getCuidado() {
        return cuidado;
    }
    public void setCuidado(String cuidado) {
        this.cuidado = cuidado;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }

    
        
}
