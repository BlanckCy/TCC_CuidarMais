package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import tcc.cuidarmais.Entity.CuidadoEntity;

public interface CuidadoRepository extends JpaRepository<CuidadoEntity, Integer> {
    CuidadoEntity findByIdcuidado(int idcuidado);
}
