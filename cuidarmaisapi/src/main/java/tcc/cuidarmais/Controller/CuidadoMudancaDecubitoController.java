package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoMudancaDecubitoEntity;
import tcc.cuidarmais.Service.CuidadoMudancaDecubitoService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-mudancadecubito")
public class CuidadoMudancaDecubitoController {

    private final CuidadoMudancaDecubitoService cuidadoMudancaDecubitoService;

    @Autowired
    public CuidadoMudancaDecubitoController(CuidadoMudancaDecubitoService cuidadoMudancaDecubitoService) {
        this.cuidadoMudancaDecubitoService = cuidadoMudancaDecubitoService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoMudancaDecubitoEntity>> listarCuidados() {
        List<CuidadoMudancaDecubitoEntity> cuidado = cuidadoMudancaDecubitoService.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{idrotina}")
    public ResponseEntity<List<CuidadoMudancaDecubitoEntity>> listarPorIdpacienteIdrotina(@PathVariable int idpaciente, @PathVariable int idrotina) {
        List<CuidadoMudancaDecubitoEntity> cuidado = cuidadoMudancaDecubitoService.listarPorIdpacienteIdrotina(idpaciente,idrotina);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/{idcuidado_mudancadecubito}")
    public ResponseEntity<CuidadoMudancaDecubitoEntity> buscarPorIdcuidado_mudancadecubito(@PathVariable int idcuidado_mudancadecubito) {
        CuidadoMudancaDecubitoEntity cuidado = cuidadoMudancaDecubitoService.buscarPorIdcuidado_mudancadecubito(idcuidado_mudancadecubito);
        if (cuidado != null) {
            return ResponseEntity.ok(cuidado);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<CuidadoMudancaDecubitoEntity>> buscarPorIdPaciente(@PathVariable int idpaciente) {
        List<CuidadoMudancaDecubitoEntity> cuidado = cuidadoMudancaDecubitoService.buscarPorIdPaciente(idpaciente);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoMudancaDecubitoEntity> salvar(@RequestBody CuidadoMudancaDecubitoEntity cuidado) {
        try {
            CuidadoMudancaDecubitoEntity novoCuidado = cuidadoMudancaDecubitoService.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_mudancadecubito}")
    public ResponseEntity<CuidadoMudancaDecubitoEntity> atualizar(@PathVariable int idcuidado_mudancadecubito, @RequestBody CuidadoMudancaDecubitoEntity cuidadoAtualizado) {
        CuidadoMudancaDecubitoEntity cuidado = cuidadoMudancaDecubitoService.buscarPorIdcuidado_mudancadecubito(idcuidado_mudancadecubito);
        if (cuidado != null) {
            cuidado.setMudanca(cuidadoAtualizado.getMudanca());
            cuidado.setHora(cuidadoAtualizado.getHora());
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setIdpaciente(cuidadoAtualizado.getIdpaciente());
            CuidadoMudancaDecubitoEntity contatoEmergenciaAtualizadoDb = cuidadoMudancaDecubitoService.salvar(cuidado);
            return new ResponseEntity<>(contatoEmergenciaAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_mudancadecubito}")
    public ResponseEntity<Void> deletar(@PathVariable int idcuidado_mudancadecubito) {
        try {
            cuidadoMudancaDecubitoService.deletar(idcuidado_mudancadecubito);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

