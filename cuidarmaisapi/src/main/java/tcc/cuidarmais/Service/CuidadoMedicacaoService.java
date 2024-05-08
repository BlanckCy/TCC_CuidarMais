package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoMedicacaoEntity;
import tcc.cuidarmais.Repository.CuidadoMedicacaoRepository;
import java.util.List;

@Service
public class CuidadoMedicacaoService {

    private final CuidadoMedicacaoRepository cuidadoMedicacaoRepository;

    @Autowired
    public CuidadoMedicacaoService(CuidadoMedicacaoRepository cuidadoMedicacaoRepository) {
        this.cuidadoMedicacaoRepository = cuidadoMedicacaoRepository;
    }

    public List<CuidadoMedicacaoEntity> listar() {
        return cuidadoMedicacaoRepository.findAll();
    }

    public List<CuidadoMedicacaoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina) {
        return cuidadoMedicacaoRepository.listarPorIdpacienteIdrotina(idpaciente,idrotina);
    }

    public CuidadoMedicacaoEntity buscarPorIdcuidado_medicacao(int idcuidado_medicacao) {
        return cuidadoMedicacaoRepository.findByIdcuidadoMedicacao(idcuidado_medicacao);
    }

    public CuidadoMedicacaoEntity salvar(CuidadoMedicacaoEntity cuidado) {
        return cuidadoMedicacaoRepository.save(cuidado);
    }

    public void deletarCuidadoMedicacao(int idcuidado_medicacao) {
        cuidadoMedicacaoRepository.deleteById(idcuidado_medicacao);
    }
}
