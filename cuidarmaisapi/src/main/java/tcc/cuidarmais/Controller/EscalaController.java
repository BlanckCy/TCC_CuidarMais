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

import tcc.cuidarmais.Entity.EscalaEntity;
import tcc.cuidarmais.Service.EscalaService;

@RestController
@RequestMapping("/escala")
public class EscalaController {
    
    private final EscalaService escalaService;

    @Autowired
    public EscalaController(EscalaService escalaService) {
        this.escalaService = escalaService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<EscalaEntity>> listar() {
        List<EscalaEntity> escala = escalaService.listar();
        return new ResponseEntity<>(escala, HttpStatus.OK);
    }

    @GetMapping("/{idescala}")
    public ResponseEntity<EscalaEntity> buscarPacientePorIdescala(@PathVariable int idescala) {
        EscalaEntity escala = escalaService.buscarPorIdescala(idescala);
        if (escala != null) {
            return new ResponseEntity<>(escala, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @GetMapping("/lista/{idpaciente}")
    public ResponseEntity<List<EscalaEntity>> buscarPorIdpaciente(@PathVariable int idpaciente) {
        List<EscalaEntity> escala = escalaService.buscarPorIdpaciente(idpaciente);
        return new ResponseEntity<>(escala, HttpStatus.OK);
    }

    @GetMapping("/{dia}/{idpaciente}")
    public ResponseEntity<List<EscalaEntity>> buscarPorDiaIdpaciente(@PathVariable String dia, @PathVariable int idpaciente) {
        List<EscalaEntity> escala = escalaService.buscarPorDiaIdpaciente(dia, idpaciente);
        return new ResponseEntity<>(escala, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<EscalaEntity> salvar(@RequestBody EscalaEntity escala) {

        EscalaEntity salvo = escalaService.salvar(escala);
        return new ResponseEntity<>(salvo, HttpStatus.CREATED);
    }

    @PutMapping("/update/{idescala}")
    public ResponseEntity<EscalaEntity> atualizarPaciente(@PathVariable int idescala, @RequestBody EscalaEntity dadoAtualizado) {
        EscalaEntity escala = escalaService.buscarPorIdescala(idescala);
        if (escala != null) {
            escala.setData_hora(dadoAtualizado.getData_hora());
            escala.setDia(dadoAtualizado.getDia());
            escala.setHora_inicio(dadoAtualizado.getHora_inicio());
            escala.setHora_final(dadoAtualizado.getHora_final());
            EscalaEntity pacienteAtualizadoDb = escalaService.salvar(escala);
            return new ResponseEntity<>(pacienteAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idescala}")
    public ResponseEntity<Void> deletarPacientePorId(@PathVariable int idescala) {
        escalaService.deletarEscalaPorId(idescala);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
