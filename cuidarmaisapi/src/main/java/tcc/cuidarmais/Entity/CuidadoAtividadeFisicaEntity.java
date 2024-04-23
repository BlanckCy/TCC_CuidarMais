package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_atividadefisica")
public class CuidadoAtividadeFisicaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidadoAtividadefisica;
    private boolean avaliacao;
    private String hora;
    private String descricao;
    private String data_hora;
    private int idpaciente;
    
    public int getIdcuidadoAtividadefisica() {
        return idcuidadoAtividadefisica;
    }
    public void setIdcuidadoAtividadefisica(int idcuidadoAtividadefisica) {
        this.idcuidadoAtividadefisica = idcuidadoAtividadefisica;
    }
    public boolean isAvaliacao() {
        return avaliacao;
    }
    public void setAvaliacao(boolean avaliacao) {
        this.avaliacao = avaliacao;
    }
    public String getHora() {
        return hora;
    }
    public void setHora(String hora) {
        this.hora = hora;
    }
    public String getDescricao() {
        return descricao;
    }
    public void setDescricao(String descricao) {
        this.descricao = descricao;
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
