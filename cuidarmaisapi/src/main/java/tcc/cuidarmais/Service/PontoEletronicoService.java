package tcc.cuidarmais.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.PontoEletronicoEntity;
import tcc.cuidarmais.Repository.PontoEletronicoRepository;

@Service
public class PontoEletronicoService {
    private final PontoEletronicoRepository pontoeletronicoRepository;

    @Autowired
    public PontoEletronicoService(PontoEletronicoRepository pontoeletronicoRepository) {
        this.pontoeletronicoRepository = pontoeletronicoRepository;
    }

    public PontoEletronicoEntity salvar(PontoEletronicoEntity escala) {
        return pontoeletronicoRepository.save(escala);
    }

    public List<PontoEletronicoEntity> listar() {
        return pontoeletronicoRepository.findAll();
    }

    public PontoEletronicoEntity buscarPorIdponto_eletronico(int idponto_eletronico) {
        return pontoeletronicoRepository.findByIdpontoEletronico(idponto_eletronico);
    }

    public PontoEletronicoEntity buscarPorDataIdpaciente(int idescala, int idpaciente) {
        return pontoeletronicoRepository.buscarPorDataIdpaciente(idescala, idpaciente);
    }    

    public void deletarEscalaPorId(int idescala) {
        pontoeletronicoRepository.deleteById(idescala);
    }
}
