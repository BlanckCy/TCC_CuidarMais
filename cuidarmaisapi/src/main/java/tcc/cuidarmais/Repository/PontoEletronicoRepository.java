package tcc.cuidarmais.Repository;

import tcc.cuidarmais.Entity.PontoEletronicoEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface PontoEletronicoRepository extends JpaRepository<PontoEletronicoEntity, Integer>{
    PontoEletronicoEntity findByIdpontoEletronico(int idponto_eletronico);

    @Query("SELECT p FROM PontoEletronicoEntity p WHERE p.idescala = ?1 and p.idpaciente = ?2")
    PontoEletronicoEntity buscarPorDataIdpaciente(int idescala, int idpaciente);
}
