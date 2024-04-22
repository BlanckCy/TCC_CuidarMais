package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoHigieneEntity;

public interface CuidadoHigieneRepository extends JpaRepository<CuidadoHigieneEntity, Integer> {
    CuidadoHigieneEntity findByIdcuidadoHigiene(int idcuidado_mudancadecubito);

    java.util.List<CuidadoHigieneEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT c FROM CuidadoHigieneEntity c WHERE c.idpaciente = ?1 AND DATE_FORMAT(c.data_hora, '%Y-%m-%d') = ?2 ")
    List<CuidadoHigieneEntity> listarCuidadoIdpacienteData(int idpaciente, String data);
}
