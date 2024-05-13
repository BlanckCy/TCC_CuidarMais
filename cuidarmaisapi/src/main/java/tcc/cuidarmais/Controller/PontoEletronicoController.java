package tcc.cuidarmais.Controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import tcc.cuidarmais.Entity.PontoEletronicoEntity;
import tcc.cuidarmais.Service.PontoEletronicoService;

@RestController
@RequestMapping("/pontoeletronico")
public class PontoEletronicoController {
    
    private final PontoEletronicoService pontoeletronicoService;

    @Autowired
    public PontoEletronicoController(PontoEletronicoService pontoeletronicoService) {
        this.pontoeletronicoService = pontoeletronicoService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<PontoEletronicoEntity>> listar() {
        List<PontoEletronicoEntity> ponto = pontoeletronicoService.listar();
        return new ResponseEntity<>(ponto, HttpStatus.OK);
    }

    @GetMapping("/{idponto_eletronico}")
    public ResponseEntity<PontoEletronicoEntity> buscarPorIdponto_eletronico(@PathVariable int idponto_eletronico) {
        PontoEletronicoEntity ponto = pontoeletronicoService.buscarPorIdponto_eletronico(idponto_eletronico);
        if (ponto != null) {
            return new ResponseEntity<>(ponto, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @GetMapping("/por-data/{idescala}/{idpaciente}")
    public ResponseEntity<PontoEletronicoEntity> buscarPorDataIdpaciente(@PathVariable int idescala, @PathVariable int idpaciente) {
        PontoEletronicoEntity ponto = pontoeletronicoService.buscarPorDataIdpaciente(idescala, idpaciente);
        if (ponto != null) {
            return new ResponseEntity<>(ponto, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @PostMapping("/create")
    public ResponseEntity<PontoEletronicoEntity> salvar(@RequestBody PontoEletronicoEntity ponto) { 
        PontoEletronicoEntity salvo = pontoeletronicoService.salvar(ponto);
        return new ResponseEntity<>(salvo, HttpStatus.CREATED);
    }

    @PutMapping("/update/{idponto_eletronico}")
    public ResponseEntity<PontoEletronicoEntity> atualizarPaciente(@PathVariable int idponto_eletronico, @RequestBody PontoEletronicoEntity dadoAtualizado) {
        PontoEletronicoEntity ponto = pontoeletronicoService.buscarPorIdponto_eletronico(idponto_eletronico);
        if (ponto != null) {
            ponto.setHora_entrada(dadoAtualizado.getHora_entrada());
            ponto.setHora_saida(dadoAtualizado.getHora_saida());
            PontoEletronicoEntity pacienteAtualizadoDb = pontoeletronicoService.salvar(ponto);
            return new ResponseEntity<>(pacienteAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idponto_eletronico}")
    public ResponseEntity<Void> deletarPacientePorId(@PathVariable int idponto_eletronico) {
        pontoeletronicoService.deletarEscalaPorId(idponto_eletronico);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
