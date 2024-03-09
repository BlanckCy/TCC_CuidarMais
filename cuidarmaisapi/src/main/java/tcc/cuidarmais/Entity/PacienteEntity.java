package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "paciente")
public class PacienteEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idpaciente;
    private String nome;
    private String email_responsavel;
    private String nome_responsavel;
    private int idade;
    private String genero;
    private int idcuidador;
    private int idnivelCuidado;

    public int getIdpaciente() {
        return idpaciente;
    }
    public void setIdpaciente(int idpaciente) {
        this.idpaciente = idpaciente;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getEmail_responsavel() {
        return email_responsavel;
    }
    public void setEmail_responsavel(String email_responsavel) {
        this.email_responsavel = email_responsavel;
    }
    public String getNome_responsavel() {
        return nome_responsavel;
    }
    public void setNome_responsavel(String nome_responsavel) {
        this.nome_responsavel = nome_responsavel;
    }
    public int getIdade() {
        return idade;
    }
    public void setIdade(int idade) {
        this.idade = idade;
    }
    public String getGenero() {
        return genero;
    }
    public void setGenero(String genero) {
        this.genero = genero;
    }
    public int getIdcuidador() {
        return idcuidador;
    }
    public void setIdcuidador(int idcuidador) {
        this.idcuidador = idcuidador;
    }
    public int getIdnivelCuidado() {
        return idnivelCuidado;
    }
    public void setIdnivelCuidado(int idnivelCuidado) {
        this.idnivelCuidado = idnivelCuidado;
    }

    
}
