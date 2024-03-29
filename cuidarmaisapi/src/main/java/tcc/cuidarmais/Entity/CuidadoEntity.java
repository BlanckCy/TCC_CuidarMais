package tcc.cuidarmais.Entity;

import java.security.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado")
public class CuidadoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidado;
    private Timestamp data_hora;
    private boolean realizado;
    private int tipo_cuidado;
    private String descricao;
    private int idpaciente;

    public int getIdcuidado() {
        return idcuidado;
    }
    public void setIdcuidado(int idcuidado) {
        this.idcuidado = idcuidado;
    }
    public Timestamp getData_hora() {
        return data_hora;
    }
    public void setData_hora(Timestamp data_hora) {
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
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
}
