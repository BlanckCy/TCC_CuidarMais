package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.RotinaEntity;

public interface RotinaRepository extends JpaRepository<RotinaEntity, Integer> {
    RotinaEntity findByIdrotina(int idrotina);

    @Query("SELECT c FROM RotinaEntity c WHERE c.idpaciente = ?1 AND c.tipo_cuidado = ?2 AND c.realizado = false")
    List<RotinaEntity> buscarPorIdpacienteTipo(int idpaciente, int tipo);

    @Query("SELECT c FROM RotinaEntity c WHERE c.idpaciente = ?1 AND c.realizado = false")
    List<RotinaEntity> buscarPorIdpacienteRotinaAtual(int idpaciente);

    @Query(value = "SELECT ro.tipo_cuidado, ro.cuidado, "+
                     "cr.avaliacao_cafe, cr.hora_cafe, cr.descricao_cafe, cr.avaliacao_almoco, cr.hora_almoco, cr.descricao_almoco, cr.descricao_jantar, cr.avaliacao_jantar, cr.hora_jantar, "+
                     "csv.pressao_sistolica, csv.pressao_diastolica, csv.temperatura, csv.frequencia_respiratoria, csv.frequencia_cardiaca, csv.descricao, "+
                     "caf.avaliacao, caf.hora, caf.descricao, "+ 
                     "ch.tarefa, ch.hora, "+
                     "cml.medicamento, cm.realizado, cm.data_hora, "+
                     "cmd.mudanca, cmd.hora " +
            "FROM rotina AS ro " +
            "LEFT OUTER JOIN cuidado_refeicao AS cr ON cr.idrotina = ro.idrotina " +
            "LEFT OUTER JOIN cuidado_sinaisvitais AS csv ON csv.idrotina = ro.idrotina " +
            "LEFT OUTER JOIN cuidado_atividadefisica AS caf ON caf.idrotina = ro.idrotina " +
            "LEFT OUTER JOIN cuidado_higiene AS ch ON ch.idrotina = ro.idrotina " +
            "LEFT OUTER JOIN cuidado_medicacao AS cm ON cm.idrotina = ro.idrotina " +
            "LEFT OUTER JOIN cuidado_medicacao_lista AS cml ON cml.idcuidado_medicacao_lista=cm.idcuidado_medicacao_lista "+
            "LEFT OUTER JOIN cuidado_mudancadecubito AS cmd ON cmd.idrotina = ro.idrotina " +
            "WHERE ro.realizado = 1 " +
            "AND ro.idpaciente = ?1 " +
            "AND DATE(ro.data_hora) = ?2 " +
            "ORDER BY ro.tipo_cuidado ASC", nativeQuery = true)
    List<Object[]> relatorioRotina(int idCliente, String data);

}
