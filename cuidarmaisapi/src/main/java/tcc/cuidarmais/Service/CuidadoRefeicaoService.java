package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoRefeicaoEntity;
import tcc.cuidarmais.Repository.CuidadoRefeicaoRepository;

import java.util.List;

@Service
public class CuidadoRefeicaoService {

    private final CuidadoRefeicaoRepository cuidadorefeicaorepository;

    @Autowired
    public CuidadoRefeicaoService(CuidadoRefeicaoRepository cuidadorefeicaorepository) {
        this.cuidadorefeicaorepository = cuidadorefeicaorepository;
    }

    public List<CuidadoRefeicaoEntity> listar() {
        return cuidadorefeicaorepository.findAll();
    }

    public List<CuidadoRefeicaoEntity> listarPorIdpacienteIdrotina(int idpaciente, int idrotina) {
        return cuidadorefeicaorepository.listarPorIdpacienteIdrotina(idpaciente,idrotina);
    }

    public CuidadoRefeicaoEntity buscarPorIdcuidado_refeicao(int idcuidado_refeicao) {
        return cuidadorefeicaorepository.findByIdcuidadoRefeicao(idcuidado_refeicao);
    }

    public List<CuidadoRefeicaoEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadorefeicaorepository.findByIdpaciente(idpaciente);
    }

    public CuidadoRefeicaoEntity salvar(CuidadoRefeicaoEntity cuidado) {
        return cuidadorefeicaorepository.save(cuidado);
    }

    public void deletar(int idcuidado_refeicao) {
        cuidadorefeicaorepository.deleteById(idcuidado_refeicao);
    }
}
