package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoMedicacaoEntity;
import tcc.cuidarmais.Service.CuidadoMedicacaoService;

import java.util.List;

@RestController
@RequestMapping("/medicacao")
public class CuidadoMedicacaoController {

    private final CuidadoMedicacaoService cuidadoMedicacaoService;

    @Autowired
    public CuidadoMedicacaoController(CuidadoMedicacaoService cuidadoMedicacaoService) {
        this.cuidadoMedicacaoService = cuidadoMedicacaoService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoMedicacaoEntity>> listarCuidadosMedicacao() {
        List<CuidadoMedicacaoEntity> medicacao = cuidadoMedicacaoService.listarCuidados();
        return new ResponseEntity<>(medicacao, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}")
    public ResponseEntity<List<CuidadoMedicacaoEntity>> listarCuidadosMedicacao(@PathVariable int idpaciente) {
        List<CuidadoMedicacaoEntity> medicacao = cuidadoMedicacaoService.listarCuidados();
        return new ResponseEntity<>(medicacao, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoMedicacaoEntity> salvarCuidado(@RequestBody CuidadoMedicacaoEntity cuidadoMedicacao) {
        try {
            CuidadoMedicacaoEntity novoCuidado = cuidadoMedicacaoService.salvarCuidadoMedicacao(cuidadoMedicacao);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_medicacao_lista}")
    public ResponseEntity<CuidadoMedicacaoEntity> atualizarCuidado(@PathVariable int idcuidado_medicacao_lista, @RequestBody CuidadoMedicacaoEntity cuidadoAtualizado) {
        CuidadoMedicacaoEntity cuidado = cuidadoMedicacaoService.buscarPorIdcuidadoMedicacaoLista(idcuidado_medicacao_lista);
        if (cuidado != null) {
            cuidado.setMedicamento(cuidadoAtualizado.getMedicamento());
            cuidado.setDosagem(cuidadoAtualizado.getDosagem());
            cuidado.setHora(cuidadoAtualizado.getHora());
            cuidado.setTipo(cuidadoAtualizado.getTipo());
            CuidadoMedicacaoEntity cuidadorAtualizadoDb = cuidadoMedicacaoService.salvarCuidadoMedicacao(cuidado);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_medicacao_lista}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable int idcuidado_medicacao_lista) {
        try {
            cuidadoMedicacaoService.deletarCuidadoMedicacao(idcuidado_medicacao_lista);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

