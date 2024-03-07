package tcc.cuidarmais.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import tcc.cuidarmais.Entity.CuidadorEntity;

public interface CuidadorRepository extends JpaRepository<CuidadorEntity, Integer> {
    CuidadorEntity findByEmail(String email);

    @Query("SELECT c FROM CuidadorEntity c WHERE c.email = ?1 AND c.senha = ?2")
    CuidadorEntity validateLogin(String email, String senha);
}

