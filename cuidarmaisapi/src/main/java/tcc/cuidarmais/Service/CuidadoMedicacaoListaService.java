package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoMedicacaoListaEntity;
import tcc.cuidarmais.Repository.CuidadoMedicacaoListaRepository;
import java.util.List;

@Service
public class CuidadoMedicacaoListaService {

    private final CuidadoMedicacaoListaRepository cuidadoMedicacaoRepository;

    @Autowired
    public CuidadoMedicacaoListaService(CuidadoMedicacaoListaRepository cuidadoMedicacaoRepository) {
        this.cuidadoMedicacaoRepository = cuidadoMedicacaoRepository;
    }

    public List<CuidadoMedicacaoListaEntity> listarCuidados() {
        return cuidadoMedicacaoRepository.findAll();
    }

    public CuidadoMedicacaoListaEntity buscarPorIdcuidado_medicacao_lista(int idcuidado_medicacao_lista) {
        return cuidadoMedicacaoRepository.findByIdcuidadoMedicacaoLista(idcuidado_medicacao_lista);
    }

    public CuidadoMedicacaoListaEntity salvar(CuidadoMedicacaoListaEntity cuidado) {
        return cuidadoMedicacaoRepository.save(cuidado);
    }

    public void deletarCuidadoMedicacao(int idcuidado_medicacao_lista) {
        cuidadoMedicacaoRepository.deleteById(idcuidado_medicacao_lista);
    }
}
