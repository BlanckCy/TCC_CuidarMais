package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_sinaisvitais")
public class CuidadoSinaisVitaisEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidadoSinaisvitais;
    private String pressao_sistolica;
    private String pressao_diastolica;
    private String temperatura;
    private String frequencia_respiratoria;
    private String frequencia_cardiaca;
    private String data_hora;
    private String descricao;
    private int idpaciente;
    private int idrotina;

    public int getIdrotina() {
        return idrotina;
    }
    public void setIdrotina(int idrotina) {
        this.idrotina = idrotina;
    }
    public int getIdcuidadoSinaisvitais() {
        return idcuidadoSinaisvitais;
    }
    public void setIdcuidadoSinaisvitais(int idcuidadoSinaisvitais) {
        this.idcuidadoSinaisvitais = idcuidadoSinaisvitais;
    }
    public String getPressao_sistolica() {
        return pressao_sistolica;
    }
    public void setPressao_sistolica(String pressao_sistolica) {
        this.pressao_sistolica = pressao_sistolica;
    }
    public String getPressao_diastolica() {
        return pressao_diastolica;
    }
    public void setPressao_diastolica(String pressao_diastolica) {
        this.pressao_diastolica = pressao_diastolica;
    }
    public String getTemperatura() {
        return temperatura;
    }
    public void setTemperatura(String temperatura) {
        this.temperatura = temperatura;
    }
    public String getFrequencia_respiratoria() {
        return frequencia_respiratoria;
    }
    public void setFrequencia_respiratoria(String frequencia_respiratoria) {
        this.frequencia_respiratoria = frequencia_respiratoria;
    }
    public String getFrequencia_cardiaca() {
        return frequencia_cardiaca;
    }
    public void setFrequencia_cardiaca(String frequencia_cardiaca) {
        this.frequencia_cardiaca = frequencia_cardiaca;
    }
    public String getData_hora() {
        return data_hora;
    }
    public void setData_hora(String data_hora) {
        this.data_hora = data_hora;
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
