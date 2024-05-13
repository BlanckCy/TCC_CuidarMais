package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "ponto_eletronico")
public class PontoEletronicoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idpontoEletronico;
    private String hora_entrada;
    private String hora_saida;
    private int idpaciente;
    private int idescala;

    public String getHora_entrada() {
        return hora_entrada;
    }
    public void setHora_entrada(String hora_entrada) {
        this.hora_entrada = hora_entrada;
    }
    public String getHora_saida() {
        return hora_saida;
    }
    public void setHora_saida(String hora_saida) {
        this.hora_saida = hora_saida;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
    public int getIdescala() {
        return idescala;
    }
    public void setIdescala(int idescala) {
        this.idescala = idescala;
    }
    public int getIdpontoEletronico() {
        return idpontoEletronico;
    }
    public void setIdpontoEletronico(int idpontoEletronico) {
        this.idpontoEletronico = idpontoEletronico;
    }
    
}
