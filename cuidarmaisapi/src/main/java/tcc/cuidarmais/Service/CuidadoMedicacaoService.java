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

    public List<CuidadoMedicacaoEntity> listarCuidados() {
        return cuidadoMedicacaoRepository.findAll();
    }

    public CuidadoMedicacaoEntity buscarPorIdcuidadoMedicacaoLista(int idcuidado_medicacao_lista) {
        return cuidadoMedicacaoRepository.findByIdcuidadoMedicacaoLista(idcuidado_medicacao_lista);
    }

    public CuidadoMedicacaoEntity salvarCuidadoMedicacao(CuidadoMedicacaoEntity cuidado) {
        return cuidadoMedicacaoRepository.save(cuidado);
    }

    public void deletarCuidadoMedicacao(int idcuidado_medicacao_lista) {
        cuidadoMedicacaoRepository.deleteById(idcuidado_medicacao_lista);
    }
}
