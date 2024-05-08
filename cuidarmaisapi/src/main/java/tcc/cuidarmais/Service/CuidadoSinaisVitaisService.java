package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoSinaisVitaisEntity;
import tcc.cuidarmais.Repository.CuidadoSinaisVitaisRepository;

import java.util.List;

@Service
public class CuidadoSinaisVitaisService {

    private final CuidadoSinaisVitaisRepository cuidadoSinaisVitaisRepository;

    @Autowired
    public CuidadoSinaisVitaisService(CuidadoSinaisVitaisRepository cuidadoSinaisVitaisRepository) {
        this.cuidadoSinaisVitaisRepository = cuidadoSinaisVitaisRepository;
    }

    public List<CuidadoSinaisVitaisEntity> listar() {
        return cuidadoSinaisVitaisRepository.findAll();
    }

    public List<CuidadoSinaisVitaisEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina) {
        return cuidadoSinaisVitaisRepository.listarPorIdpacienteIdrotina(idpaciente,idrotina);
    }

    public CuidadoSinaisVitaisEntity buscarPorIdcuidado_sinaisvitais(int idcuidado_sinaisvitais) {
        return cuidadoSinaisVitaisRepository.findByIdcuidadoSinaisvitais(idcuidado_sinaisvitais);
    }

    public List<CuidadoSinaisVitaisEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadoSinaisVitaisRepository.findByIdpaciente(idpaciente);
    }

    public CuidadoSinaisVitaisEntity salvar(CuidadoSinaisVitaisEntity contato) {
        return cuidadoSinaisVitaisRepository.save(contato);
    }

    public void deletar(int idcuidado_sinaisvitais) {
        cuidadoSinaisVitaisRepository.deleteById(idcuidado_sinaisvitais);
    }
}
