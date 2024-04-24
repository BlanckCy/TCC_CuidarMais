package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoMedicacaoEntity;
import tcc.cuidarmais.Service.CuidadoMedicacaoService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-medicacao")
public class CuidadoMedicacaoController {

    private final CuidadoMedicacaoService cuidadoMedicacaoService;

    @Autowired
    public CuidadoMedicacaoController(CuidadoMedicacaoService cuidadoMedicacaoService) {
        this.cuidadoMedicacaoService = cuidadoMedicacaoService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoMedicacaoEntity>> listarCuidadosMedicacao() {
        List<CuidadoMedicacaoEntity> cuidado = cuidadoMedicacaoService.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{idrotina}")
    public ResponseEntity<List<CuidadoMedicacaoEntity>> listarCuidadosMedicacao(@PathVariable int idpaciente, @PathVariable int idrotina) {
        List<CuidadoMedicacaoEntity> cuidado = cuidadoMedicacaoService.listarPorIdpacienteIdrotina(idpaciente,idrotina);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoMedicacaoEntity> salvar(@RequestBody CuidadoMedicacaoEntity cuidado) {
        try {
            CuidadoMedicacaoEntity novoCuidado = cuidadoMedicacaoService.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_medicacao}")
    public ResponseEntity<CuidadoMedicacaoEntity> atualizar(@PathVariable int idcuidado_medicacao, @RequestBody CuidadoMedicacaoEntity cuidadoAtualizado) {
        CuidadoMedicacaoEntity cuidado = cuidadoMedicacaoService.buscarPorIdcuidado_medicacao(idcuidado_medicacao);
        if (cuidado != null) {
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setRealizado(cuidadoAtualizado.isRealizado());
            
            CuidadoMedicacaoEntity cuidadorAtualizadoDb = cuidadoMedicacaoService.salvar(cuidado);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_medicacao}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable int idcuidado_medicacao) {
        try {
            cuidadoMedicacaoService.deletarCuidadoMedicacao(idcuidado_medicacao);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

