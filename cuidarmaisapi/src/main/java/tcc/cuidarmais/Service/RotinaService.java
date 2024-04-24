package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.RotinaEntity;
import tcc.cuidarmais.Repository.RotinaRepository;

import java.util.List;

@Service
public class RotinaService {

    private final RotinaRepository cuidadoRepository;

    @Autowired
    public RotinaService(RotinaRepository cuidadoRepository) {
        this.cuidadoRepository = cuidadoRepository;
    }

    public List<RotinaEntity> listar() {
        return cuidadoRepository.findAll();
    }

    public List<RotinaEntity> buscarPorIdpacienteTipo(int idpaciente, int tipo) {
        return cuidadoRepository.buscarPorIdpacienteTipo(idpaciente,tipo);
    }

    public RotinaEntity buscarPorIdrotina(int idrotina) {
        return cuidadoRepository.findByIdrotina(idrotina);
    }

    public RotinaEntity salvar(RotinaEntity cuidado) {
        return cuidadoRepository.save(cuidado);
    }

    public void deletar(int id) {
        cuidadoRepository.deleteById(id);
    }
}
