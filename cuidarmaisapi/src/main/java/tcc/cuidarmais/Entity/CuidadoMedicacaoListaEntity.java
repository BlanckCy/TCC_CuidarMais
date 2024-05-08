package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_medicacao_lista")
public class CuidadoMedicacaoListaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcuidadoMedicacaoLista;
    
    private String medicamento;
    private String dosagem;
    private String hora;
    private String tipo;
    private int idpaciente;

    public int getIdcuidadoMedicacaoLista() {
        return idcuidadoMedicacaoLista;
    }
    public void setIdcuidadoMedicacaoLista(int idcuidadoMedicacaoLista) {
        this.idcuidadoMedicacaoLista = idcuidadoMedicacaoLista;
    }
    public String getMedicamento() {
        return medicamento;
    }
    public void setMedicamento(String medicamento) {
        this.medicamento = medicamento;
    }
    public String getDosagem() {
        return dosagem;
    }
    public void setDosagem(String dosagem) {
        this.dosagem = dosagem;
    }
    public String getHora() {
        return hora;
    }
    public void setHora(String hora) {
        this.hora = hora;
    }
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }

    
}
