package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;
import tcc.cuidarmais.Service.ContatoEmergenciaService;

import java.util.List;

@RestController
@RequestMapping("/contatoemergencia")
public class ContatoEmergenciaController {

    private final ContatoEmergenciaService contatoEmergenciaService;

    @Autowired
    public ContatoEmergenciaController(ContatoEmergenciaService contatoEmergenciaService) {
        this.contatoEmergenciaService = contatoEmergenciaService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<ContatoEmergenciaEntity>> listarCuidados() {
        List<ContatoEmergenciaEntity> contatos = contatoEmergenciaService.listar();
        return new ResponseEntity<>(contatos, HttpStatus.OK);
    }

    @GetMapping("/{idcontato_emergencia}")
    public ResponseEntity<ContatoEmergenciaEntity> buscarContatosPoridcontato_emergencia(@PathVariable int idcontato_emergencia) {
        ContatoEmergenciaEntity contato = contatoEmergenciaService.buscarPorIdcontato_emergencia(idcontato_emergencia);
        if (contato != null) {
            return ResponseEntity.ok(contato);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<ContatoEmergenciaEntity>> buscarContatosPorIdPaciente(@PathVariable int idpaciente) {
        List<ContatoEmergenciaEntity> contatos = contatoEmergenciaService.buscarContatosPorIdPaciente(idpaciente);
        return new ResponseEntity<>(contatos, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<ContatoEmergenciaEntity> salvarCuidado(@RequestBody ContatoEmergenciaEntity contatoEmergencia) {
        try {
            ContatoEmergenciaEntity novoContato = contatoEmergenciaService.salvar(contatoEmergencia);
            return new ResponseEntity<>(novoContato, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcontato_emergencia}")
    public ResponseEntity<ContatoEmergenciaEntity> atualizarCuidador(@PathVariable int idcontato_emergencia, @RequestBody ContatoEmergenciaEntity contatoAtualizado) {
        ContatoEmergenciaEntity contatoEmergencia = contatoEmergenciaService.buscarPorIdcontato_emergencia(idcontato_emergencia);
        if (contatoEmergencia != null) {
            contatoEmergencia.setNome(contatoAtualizado.getNome());
            contatoEmergencia.setTelefone(contatoAtualizado.getTelefone());
            contatoEmergencia.setParentesco(contatoAtualizado.getParentesco());
            ContatoEmergenciaEntity contatoEmergenciaAtualizadoDb = contatoEmergenciaService.salvar(contatoEmergencia);
            return new ResponseEntity<>(contatoEmergenciaAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcontato_emergencia}")
    public ResponseEntity<Void> deletarContato(@PathVariable int idcontato_emergencia) {
        try {
            contatoEmergenciaService.deletar(idcontato_emergencia);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

