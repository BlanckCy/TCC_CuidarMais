package tcc.cuidarmais.Entity;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Time;

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
    
    private String data_hora;
    private boolean realizado;
    private int tipo_cuidado;
    private String cuidado;
    private String descricao;
    private String horario_realizado;
    private boolean avaliacao;
    private int idpaciente;

    public int getIdcuidado() {
        return idcuidado;
    }
    public void setIdcuidado(int idcuidado) {
        this.idcuidado = idcuidado;
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
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }
    public String getHorario_realizado() {
        return horario_realizado;
    }
    public void setHorario_realizado(String horario_realizado) {
        this.horario_realizado = horario_realizado;
    }
    public boolean isAvaliacao() {
        return avaliacao;
    }
    public void setAvaliacao(boolean avaliacao) {
        this.avaliacao = avaliacao;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }

        
}
