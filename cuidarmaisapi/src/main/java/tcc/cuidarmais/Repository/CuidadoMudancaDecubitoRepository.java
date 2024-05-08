package tcc.cuidarmais.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadoMudancaDecubitoEntity;

public interface CuidadoMudancaDecubitoRepository extends JpaRepository<CuidadoMudancaDecubitoEntity, Integer> {
    CuidadoMudancaDecubitoEntity findByIdcuidadoMudancadecubito(int idcuidado_mudancadecubito);

    java.util.List<CuidadoMudancaDecubitoEntity> findByIdpaciente(int idpaciente);

    @Query("SELECT c FROM CuidadoMudancaDecubitoEntity c WHERE c.idpaciente = ?1 AND c.idrotina = ?2 ")
    List<CuidadoMudancaDecubitoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina);
}
