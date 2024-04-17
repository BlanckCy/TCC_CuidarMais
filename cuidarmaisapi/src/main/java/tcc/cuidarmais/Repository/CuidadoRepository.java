package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoEntity;

public interface CuidadoRepository extends JpaRepository<CuidadoEntity, Integer> {
    CuidadoEntity findByIdcuidado(int idcuidado);

    @Query("SELECT c FROM CuidadoEntity c WHERE c.tipo_cuidado = ?1 AND DATE_FORMAT(c.data_hora, '%Y-%m-%d') = ?2 AND c.realizado = false")
    List<CuidadoEntity> buscarCuidadoPorTipoData(int tipo, String data);
}
