package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoRefeicaoEntity;

public interface CuidadoRefeicaoRepository extends JpaRepository<CuidadoRefeicaoEntity, Integer> {
    CuidadoRefeicaoEntity findByIdcuidadoRefeicao(int idcuidado_atividadefisica);

    java.util.List<CuidadoRefeicaoEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT c FROM CuidadoRefeicaoEntity c WHERE c.idpaciente = ?1 AND c.idrotina = ?2 ")
    List<CuidadoRefeicaoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina);
}
