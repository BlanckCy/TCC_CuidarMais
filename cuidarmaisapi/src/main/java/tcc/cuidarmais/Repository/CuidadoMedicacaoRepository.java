package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoMedicacaoEntity;

public interface CuidadoMedicacaoRepository extends JpaRepository<CuidadoMedicacaoEntity, Integer> {
    CuidadoMedicacaoEntity findByIdcuidadoMedicacao(int idcuidado_medicacao);

    @Query("SELECT c FROM CuidadoMedicacaoEntity c WHERE c.idpaciente = ?1 AND c.idrotina = ?2 ")
    java.util.List<CuidadoMedicacaoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina);
}
