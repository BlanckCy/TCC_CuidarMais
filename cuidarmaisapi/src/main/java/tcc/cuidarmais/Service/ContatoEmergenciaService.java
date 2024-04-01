package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;
import tcc.cuidarmais.Repository.ContatoEmergenciaRepository;

import java.util.List;

@Service
public class ContatoEmergenciaService {

    private final ContatoEmergenciaRepository contatoEmergenciaRepository;

    @Autowired
    public ContatoEmergenciaService(ContatoEmergenciaRepository contatoEmergenciaRepository) {
        this.contatoEmergenciaRepository = contatoEmergenciaRepository;
    }

    public List<ContatoEmergenciaEntity> listarContatos() {
        return contatoEmergenciaRepository.findAll();
    }

    public ContatoEmergenciaEntity buscarPorIdcontato_emergencia(int idcontato_emergencia) {
        return contatoEmergenciaRepository.findByIdcontato_emergencia(idcontato_emergencia);
    }

    public List<ContatoEmergenciaEntity> buscarContatosPorIdPaciente(int idpaciente) {
        return contatoEmergenciaRepository.findByIdpaciente(idpaciente);
    }

    public ContatoEmergenciaEntity salvarContato(ContatoEmergenciaEntity contato) {
        return contatoEmergenciaRepository.save(contato);
    }

    public void deletarContato(int idcontato_emergencia) {
        contatoEmergenciaRepository.deleteById(idcontato_emergencia);
    }
}
