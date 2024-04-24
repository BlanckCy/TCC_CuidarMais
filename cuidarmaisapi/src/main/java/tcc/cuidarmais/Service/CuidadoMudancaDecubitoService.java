package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoMudancaDecubitoEntity;
import tcc.cuidarmais.Repository.CuidadoMudancaDecubitoRepository;

import java.util.List;

@Service
public class CuidadoMudancaDecubitoService {

    private final CuidadoMudancaDecubitoRepository cuidadoMudancaDecubitoRepository;

    @Autowired
    public CuidadoMudancaDecubitoService(CuidadoMudancaDecubitoRepository cuidadoMudancaDecubitoRepository) {
        this.cuidadoMudancaDecubitoRepository = cuidadoMudancaDecubitoRepository;
    }

    public List<CuidadoMudancaDecubitoEntity> listar() {
        return cuidadoMudancaDecubitoRepository.findAll();
    }

    public List<CuidadoMudancaDecubitoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina) {
        return cuidadoMudancaDecubitoRepository.listarPorIdpacienteIdrotina(idpaciente,idrotina);
    }

    public CuidadoMudancaDecubitoEntity buscarPorIdcuidado_mudancadecubito(int idcuidado_mudancadecubito) {
        return cuidadoMudancaDecubitoRepository.findByIdcuidadoMudancadecubito(idcuidado_mudancadecubito);
    }

    public List<CuidadoMudancaDecubitoEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadoMudancaDecubitoRepository.findByIdpaciente(idpaciente);
    }

    public CuidadoMudancaDecubitoEntity salvar(CuidadoMudancaDecubitoEntity cuidado) {
        return cuidadoMudancaDecubitoRepository.save(cuidado);
    }

    public void deletar(int idcuidado_mudancadecubito) {
        cuidadoMudancaDecubitoRepository.deleteById(idcuidado_mudancadecubito);
    }
}
