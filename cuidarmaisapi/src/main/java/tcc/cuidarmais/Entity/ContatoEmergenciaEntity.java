package tcc.cuidarmais.Entity;

import java.security.Timestamp;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "contatoEmergencia")
public class ContatoEmergenciaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcontatoEmergencia;
    private String nome;
    private String telefone;
    private String parentesco;
    private int idpaciente;

    public int getIdcontatoEmergencia() {
        return idcontatoEmergencia;
    }
    public void setIdcontatoEmergencia(int idcontatoEmergencia) {
        this.idcontatoEmergencia = idcontatoEmergencia;
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
