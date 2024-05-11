package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;

public interface ContatoEmergenciaRepository extends JpaRepository<ContatoEmergenciaEntity, Integer> {
    @Query("SELECT p FROM ContatoEmergenciaEntity p WHERE p.idpaciente = ?1")
    java.util.List<ContatoEmergenciaEntity> findByIdpaciente(int idpaciente);

    ContatoEmergenciaEntity findByIdcontatoEmergencia(int idcontato_emergencia);    
}
