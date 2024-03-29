package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;

public interface ContatoEmergenciaRepository extends JpaRepository<ContatoEmergenciaEntity, Integer> {
    ContatoEmergenciaEntity findByIdcontatoEmergencia(int idcontatoEmergencia);
}
