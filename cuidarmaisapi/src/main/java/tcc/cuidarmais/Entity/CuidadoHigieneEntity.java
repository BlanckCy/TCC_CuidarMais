package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_higiene")
public class CuidadoHigieneEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidadoHigiene;
    private String tarefa;
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
    public int getIdcuidadoHigiene() {
        return idcuidadoHigiene;
    }
    public void setIdcuidadoHigiene(int idcuidadoHigiene) {
        this.idcuidadoHigiene = idcuidadoHigiene;
    }
    public String getTarefa() {
        return tarefa;
    }
    public void setTarefa(String tarefa) {
        this.tarefa = tarefa;
    }
    public String getHora() {
        return hora;
    }
    public void setHora(String hora) {
        this.hora = hora;
    }
    public String getData_hora() {
        return data_hora;
    }
    public void setData_hora(String data_hora) {
        this.data_hora = data_hora;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    } 
}
