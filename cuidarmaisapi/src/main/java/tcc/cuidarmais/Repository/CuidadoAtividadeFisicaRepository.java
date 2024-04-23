package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoAtividadeFisicaEntity;

public interface CuidadoAtividadeFisicaRepository extends JpaRepository<CuidadoAtividadeFisicaEntity, Integer> {
    CuidadoAtividadeFisicaEntity findByIdcuidadoAtividadefisica(int idcuidado_atividadefisica);

    java.util.List<CuidadoAtividadeFisicaEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT c FROM CuidadoAtividadeFisicaEntity c WHERE c.idpaciente = ?1 AND DATE_FORMAT(c.data_hora, '%Y-%m-%d') = ?2 ")
    List<CuidadoAtividadeFisicaEntity> listarCuidadoIdpacienteData(int idpaciente, String data);
}
