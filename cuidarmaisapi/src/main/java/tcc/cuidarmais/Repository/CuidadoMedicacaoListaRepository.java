package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tcc.cuidarmais.Entity.CuidadoMedicacaoListaEntity;

public interface CuidadoMedicacaoListaRepository extends JpaRepository<CuidadoMedicacaoListaEntity, Integer> {
    CuidadoMedicacaoListaEntity findByIdcuidadoMedicacaoLista(int idcuidado_medicacao_lista);
}
