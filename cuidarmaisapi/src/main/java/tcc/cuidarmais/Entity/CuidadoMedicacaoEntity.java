package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_medicacao")
public class CuidadoMedicacaoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcuidadoMedicacao;
    
    private String data_hora;
    private boolean realizado;
    private int idcuidado_medicacao_lista;
    private int idpaciente;
    private int idrotina;

    public int getIdcuidadoMedicacao() {
        return idcuidadoMedicacao;
    }
    public void setIdcuidadoMedicacao(int idcuidadoMedicacao) {
        this.idcuidadoMedicacao = idcuidadoMedicacao;
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
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
    public int getIdrotina() {
        return idrotina;
    }
    public void setIdrotina(int idrotina) {
        this.idrotina = idrotina;
    }
    public int getIdcuidado_medicacao_lista() {
        return idcuidado_medicacao_lista;
    }
    public void setIdcuidado_medicacao_lista(int idcuidado_medicacao_lista) {
        this.idcuidado_medicacao_lista = idcuidado_medicacao_lista;
    }
}
