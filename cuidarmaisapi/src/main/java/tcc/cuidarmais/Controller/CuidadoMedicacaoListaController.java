package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoMedicacaoListaEntity;
import tcc.cuidarmais.Service.CuidadoMedicacaoListaService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-medicacaolista")
public class CuidadoMedicacaoListaController {

    private final CuidadoMedicacaoListaService cuidadoMedicacaoListaService;

    @Autowired
    public CuidadoMedicacaoListaController(CuidadoMedicacaoListaService cuidadoMedicacaoListaService) {
        this.cuidadoMedicacaoListaService = cuidadoMedicacaoListaService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoMedicacaoListaEntity>> listarCuidadosMedicacao() {
        List<CuidadoMedicacaoListaEntity> cuidado = cuidadoMedicacaoListaService.listarCuidados();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}")
    public ResponseEntity<List<CuidadoMedicacaoListaEntity>> listarCuidadosMedicacao(@PathVariable int idpaciente) {
        List<CuidadoMedicacaoListaEntity> cuidado = cuidadoMedicacaoListaService.listarCuidados();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoMedicacaoListaEntity> salvar(@RequestBody CuidadoMedicacaoListaEntity cuidado) {
        try {
            CuidadoMedicacaoListaEntity novoCuidado = cuidadoMedicacaoListaService.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_medicacao_lista}")
    public ResponseEntity<CuidadoMedicacaoListaEntity> atualizar(@PathVariable int idcuidado_medicacao_lista, @RequestBody CuidadoMedicacaoListaEntity cuidadoAtualizado) {
        CuidadoMedicacaoListaEntity cuidado = cuidadoMedicacaoListaService.buscarPorIdcuidado_medicacao_lista(idcuidado_medicacao_lista);
        if (cuidado != null) {
            cuidado.setMedicamento(cuidadoAtualizado.getMedicamento());
            cuidado.setDosagem(cuidadoAtualizado.getDosagem());
            cuidado.setHora(cuidadoAtualizado.getHora());
            cuidado.setTipo(cuidadoAtualizado.getTipo());
            CuidadoMedicacaoListaEntity cuidadorAtualizadoDb = cuidadoMedicacaoListaService.salvar(cuidado);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_medicacao_lista}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable int idcuidado_medicacao_lista) {
        try {
            cuidadoMedicacaoListaService.deletarCuidadoMedicacao(idcuidado_medicacao_lista);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

