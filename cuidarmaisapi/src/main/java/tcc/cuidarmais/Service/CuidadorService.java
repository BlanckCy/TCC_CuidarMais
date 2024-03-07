package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadorEntity;
import tcc.cuidarmais.Repository.CuidadorRepository;

import java.util.List;

@Service
public class CuidadorService {

    private final CuidadorRepository cuidadorRepository;

    @Autowired
    public CuidadorService(CuidadorRepository cuidadorRepository) {
        this.cuidadorRepository = cuidadorRepository;
    }

    public List<CuidadorEntity> listarCuidadores() {
        return cuidadorRepository.findAll();
    }

    public CuidadorEntity encontrarCuidadorPorEmail(String email) {
        return cuidadorRepository.findByEmail(email);
    }

    public CuidadorEntity validateLogin(String email, String senha) {
        return cuidadorRepository.validateLogin(email, senha);
    }

    public CuidadorEntity salvarCuidador(CuidadorEntity cuidador) {
        return cuidadorRepository.save(cuidador);
    }

    public void deletarCuidador(int id) {
        cuidadorRepository.deleteById(id);
    }
}
