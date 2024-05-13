package tcc.cuidarmais.Repository;

import tcc.cuidarmais.Entity.EscalaEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EscalaRepository extends JpaRepository<EscalaEntity, Integer>{
    EscalaEntity findByIdescala(int idescala);
    java.util.List<EscalaEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT p FROM EscalaEntity p WHERE p.dia = ?1 and p.idpaciente = ?2")
    EscalaEntity buscarPorDiaIdpaciente(String dia, int idpaciente);
}
