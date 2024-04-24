package tcc.cuidarmais.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cuidado_refeicao")
public class CuidadoRefeicaoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private int idcuidadoRefeicao;

    private boolean avaliacao_cafe;
    private String hora_cafe;
    private String descricao_cafe;

    private boolean avaliacao_almoco;
    private String hora_almoco;
    private String descricao_almoco;

    private boolean avaliacao_jantar;
    private String hora_jantar;
    private String descricao_jantar;

    private String data_hora;
    private int idpaciente;
    private int idrotina;

    public int getIdrotina() {
        return idrotina;
    }
    public void setIdrotina(int idrotina) {
        this.idrotina = idrotina;
    }
    public int getIdcuidadoRefeicao() {
        return idcuidadoRefeicao;
    }
    public void setIdcuidadoRefeicao(int idcuidadoRefeicao) {
        this.idcuidadoRefeicao = idcuidadoRefeicao;
    }
    public boolean isAvaliacao_cafe() {
        return avaliacao_cafe;
    }
    public void setAvaliacao_cafe(boolean avaliacao_cafe) {
        this.avaliacao_cafe = avaliacao_cafe;
    }
    public String getHora_cafe() {
        return hora_cafe;
    }
    public void setHora_cafe(String hora_cafe) {
        this.hora_cafe = hora_cafe;
    }
    public String getDescricao_cafe() {
        return descricao_cafe;
    }
    public void setDescricao_cafe(String descricao_cafe) {
        this.descricao_cafe = descricao_cafe;
    }
    public boolean isAvaliacao_almoco() {
        return avaliacao_almoco;
    }
    public void setAvaliacao_almoco(boolean avaliacao_almoco) {
        this.avaliacao_almoco = avaliacao_almoco;
    }
    public String getHora_almoco() {
        return hora_almoco;
    }
    public void setHora_almoco(String hora_almoco) {
        this.hora_almoco = hora_almoco;
    }
    public String getDescricao_almoco() {
        return descricao_almoco;
    }
    public void setDescricao_almoco(String descricao_almoco) {
        this.descricao_almoco = descricao_almoco;
    }
    public boolean isAvaliacao_jantar() {
        return avaliacao_jantar;
    }
    public void setAvaliacao_jantar(boolean avaliacao_jantar) {
        this.avaliacao_jantar = avaliacao_jantar;
    }
    public String getHora_jantar() {
        return hora_jantar;
    }
    public void setHora_jantar(String hora_jantar) {
        this.hora_jantar = hora_jantar;
    }
    public String getDescricao_jantar() {
        return descricao_jantar;
    }
    public void setDescricao_jantar(String descricao_jantar) {
        this.descricao_jantar = descricao_jantar;
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
