package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;

public interface ContatoEmergenciaRepository extends JpaRepository<ContatoEmergenciaEntity, Integer> {
    @Query("SELECT p FROM ContatoEmergenciaEntity p WHERE p.idpaciente = ?1")
    java.util.List<ContatoEmergenciaEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT p FROM ContatoEmergenciaEntity p WHERE p.idcontato_emergencia = ?1")
    ContatoEmergenciaEntity findByIdcontato_emergencia(int idcontato_emergencia);    
}
