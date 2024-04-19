package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import tcc.cuidarmais.Entity.CuidadoMedicacaoEntity;

public interface CuidadoMedicacaoRepository extends JpaRepository<CuidadoMedicacaoEntity, Integer> {
    CuidadoMedicacaoEntity findByIdcuidadoMedicacaoLista(int idcuidado_medicacao_lista);
}
