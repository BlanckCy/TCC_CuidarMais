package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.RotinaEntity;

public interface RotinaRepository extends JpaRepository<RotinaEntity, Integer> {
    RotinaEntity findByIdrotina(int idrotina);

    @Query("SELECT c FROM RotinaEntity c WHERE c.idpaciente = ?1 AND c.tipo_cuidado = ?2 AND c.realizado = false")
    List<RotinaEntity> buscarPorIdpacienteTipo(int idpaciente, int tipo);
}
