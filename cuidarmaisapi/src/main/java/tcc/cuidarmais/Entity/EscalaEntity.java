package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "escala")
public class EscalaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idescala;
    private String data_hora;
    private String dia;
    private String hora_inicio;
    private String hora_final;
    private int idpaciente;

    public int getIdescala() {
        return idescala;
    }
    public void setIdescala(int idescala) {
        this.idescala = idescala;
    }
    public String getData_hora() {
        return data_hora;
    }
    public void setData_hora(String data_hora) {
        this.data_hora = data_hora;
    }
    public String getDia() {
        return dia;
    }
    public void setDia(String dia) {
        this.dia = dia;
    }
    public String getHora_inicio() {
        return hora_inicio;
    }
    public void setHora_inicio(String hora_inicio) {
        this.hora_inicio = hora_inicio;
    }
    public String getHora_final() {
        return hora_final;
    }
    public void setHora_final(String hora_final) {
        this.hora_final = hora_final;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
}
