package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.CuidadoAtividadeFisicaEntity;
import tcc.cuidarmais.Repository.CuidadoAtividadeFisicaRepository;

import java.util.List;

@Service
public class CuidadoAtividadeFisicaService {

    private final CuidadoAtividadeFisicaRepository cuidadoatividadefisicarepository;

    @Autowired
    public CuidadoAtividadeFisicaService(CuidadoAtividadeFisicaRepository cuidadoatividadefisicarepository) {
        this.cuidadoatividadefisicarepository = cuidadoatividadefisicarepository;
    }

    public List<CuidadoAtividadeFisicaEntity> listar() {
        return cuidadoatividadefisicarepository.findAll();
    }

    public List<CuidadoAtividadeFisicaEntity> listarCuidadoIdpacienteData(int idpaciente, String data) {
        return cuidadoatividadefisicarepository.listarCuidadoIdpacienteData(idpaciente,data);
    }

    public CuidadoAtividadeFisicaEntity buscarPorIdcuidado_atividadefisica(int idcuidado_atividadefisica) {
        return cuidadoatividadefisicarepository.findByIdcuidadoAtividadefisica(idcuidado_atividadefisica);
    }

    public List<CuidadoAtividadeFisicaEntity> buscarPorIdPaciente(int idpaciente) {
        return cuidadoatividadefisicarepository.findByIdpaciente(idpaciente);
    }

    public CuidadoAtividadeFisicaEntity salvar(CuidadoAtividadeFisicaEntity cuidado) {
        return cuidadoatividadefisicarepository.save(cuidado);
    }

    public void deletar(int idcuidado_atividadefisica) {
        cuidadoatividadefisicarepository.deleteById(idcuidado_atividadefisica);
    }
}
