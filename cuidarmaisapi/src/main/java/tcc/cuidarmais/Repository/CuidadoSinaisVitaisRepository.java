package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoSinaisVitaisEntity;

public interface CuidadoSinaisVitaisRepository extends JpaRepository<CuidadoSinaisVitaisEntity, Integer> {
    CuidadoSinaisVitaisEntity findByIdcuidadoSinaisvitais(int idcuidado_sinaisvitais);

    java.util.List<CuidadoSinaisVitaisEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT c FROM CuidadoSinaisVitaisEntity c WHERE c.idpaciente = ?1 AND DATE_FORMAT(c.data_hora, '%Y-%m-%d') = ?2 ")
    List<CuidadoSinaisVitaisEntity> listaPorClienteData(int idpaciente, String data);
}
