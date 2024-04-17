package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "contato_emergencia")
public class ContatoEmergenciaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcontato_emergencia;
    private String nome;
    private String telefone;
    private String parentesco;
    private int idpaciente;

    public int getidcontato_emergencia() {
        return idcontato_emergencia;
    }
    public void setidcontato_emergencia(int idcontato_emergencia) {
        this.idcontato_emergencia = idcontato_emergencia;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getTelefone() {
        return telefone;
    }
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    public String getParentesco() {
        return parentesco;
    }
    public void setParentesco(String parentesco) {
        this.parentesco = parentesco;
    }
    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }    
}
