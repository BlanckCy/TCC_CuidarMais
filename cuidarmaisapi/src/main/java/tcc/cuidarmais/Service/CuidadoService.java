package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoEntity;
import tcc.cuidarmais.Repository.CuidadoRepository;

import java.util.List;

@Service
public class CuidadoService {

    private final CuidadoRepository cuidadoRepository;

    @Autowired
    public CuidadoService(CuidadoRepository cuidadoRepository) {
        this.cuidadoRepository = cuidadoRepository;
    }

    public List<CuidadoEntity> listarCuidados() {
        return cuidadoRepository.findAll();
    }

    public List<CuidadoEntity> listarCuidadosPorTipoData(int tipo, String data, int idpaciente) {
        return cuidadoRepository.buscarCuidadoPorTipoData(tipo, data, idpaciente);
    }

    public List<CuidadoEntity> listarCuidadosPorTipoIdcuidadomedicacaolista(int tipo, int idcuidadoMedicacaoLista, int idpaciente) {
        return cuidadoRepository.listarCuidadosPorTipoIdcuidadomedicacaolista(tipo, idcuidadoMedicacaoLista, idpaciente);
    }

    public CuidadoEntity buscarPorIdcuidado(int idcuidado) {
        return cuidadoRepository.findByIdcuidado(idcuidado);
    }

    public CuidadoEntity salvarCuidado(CuidadoEntity cuidado) {
        return cuidadoRepository.save(cuidado);
    }

    public void deletarCuidado(int id) {
        cuidadoRepository.deleteById(id);
    }
}
