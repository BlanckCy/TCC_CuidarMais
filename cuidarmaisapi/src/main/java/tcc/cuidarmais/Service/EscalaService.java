package tcc.cuidarmais.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.EscalaEntity;
import tcc.cuidarmais.Repository.EscalaRepository;

@Service
public class EscalaService {
    private final EscalaRepository escalaRepository;

    @Autowired
    public EscalaService(EscalaRepository escalaRepository) {
        this.escalaRepository = escalaRepository;
    }

    public EscalaEntity salvar(EscalaEntity escala) {
        return escalaRepository.save(escala);
    }

    public List<EscalaEntity> listar() {
        return escalaRepository.findAll();
    }

    public List<EscalaEntity> buscarPorDiaIdpaciente(String dia, int idescala) {
        return escalaRepository.buscarPorDiaIdpaciente(dia, idescala);
    }

    public List<EscalaEntity> buscarPorIdpaciente(int idpaciente) {
        return escalaRepository.findByIdpaciente(idpaciente);
    }

    public EscalaEntity buscarPorIdescala(int idescala) {
        return escalaRepository.findByIdescala(idescala);
    }    

    public void deletarEscalaPorId(int idescala) {
        escalaRepository.deleteById(idescala);
    }
}
