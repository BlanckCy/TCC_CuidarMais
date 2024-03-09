package tcc.cuidarmais.Repository;

import tcc.cuidarmais.Entity.PacienteEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PacienteRepository extends JpaRepository<PacienteEntity, Integer>{
    @Query("SELECT p FROM PacienteEntity p WHERE p.idcuidador = ?1")
    java.util.List<PacienteEntity> findByCuidadorId(int idCuidador);
}
