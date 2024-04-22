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

    public List<CuidadoMudancaDecubitoEntity> listarContatos() {
        return cuidadoMudancaDecubitoRepository.findAll();
    }

    public List<CuidadoMudancaDecubitoEntity> listaPorClienteData(int idpaciente, String data) {
        return cuidadoMudancaDecubitoRepository.listaPorClienteData(idpaciente,data);
    }

    public CuidadoMudancaDecubitoEntity buscarPorIdcuidado_mudancadecubito(int idcuidado_mudancadecubito) {
        return cuidadoMudancaDecubitoRepository.findByIdcuidadoMudancadecubito(idcuidado_mudancadecubito);
    }

    public List<CuidadoMudancaDecubitoEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadoMudancaDecubitoRepository.findByIdpaciente(idpaciente);
    }

    public CuidadoMudancaDecubitoEntity salvar(CuidadoMudancaDecubitoEntity contato) {
        return cuidadoMudancaDecubitoRepository.save(contato);
    }

    public void deletar(int idcuidado_mudancadecubito) {
        cuidadoMudancaDecubitoRepository.deleteById(idcuidado_mudancadecubito);
    }
}
