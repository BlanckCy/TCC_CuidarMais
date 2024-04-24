package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoHigieneEntity;
import tcc.cuidarmais.Repository.CuidadoHigieneRepository;

import java.util.List;

@Service
public class CuidadoHigieneService {

    private final CuidadoHigieneRepository cuidadohigienerepository;

    @Autowired
    public CuidadoHigieneService(CuidadoHigieneRepository cuidadohigienerepository) {
        this.cuidadohigienerepository = cuidadohigienerepository;
    }

    public List<CuidadoHigieneEntity> listar() {
        return cuidadohigienerepository.findAll();
    }

    public List<CuidadoHigieneEntity> listarCuidadoIdpacienteIdrotina(int idpaciente, int idrotina) {
        return cuidadohigienerepository.listarCuidadoIdpacienteIdrotina(idpaciente,idrotina);
    }

    public CuidadoHigieneEntity buscarPorIdcuidado_higiene(int idcuidado_higiene) {
        return cuidadohigienerepository.findByIdcuidadoHigiene(idcuidado_higiene);
    }

    public List<CuidadoHigieneEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadohigienerepository.findByIdpaciente(idpaciente);
    }

    public CuidadoHigieneEntity salvar(CuidadoHigieneEntity cuidado) {
        return cuidadohigienerepository.save(cuidado);
    }

    public void deletar(int idcuidado_higiene) {
        cuidadohigienerepository.deleteById(idcuidado_higiene);
    }
}
