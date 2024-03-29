package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.ContatoEmergenciaEntity;
import tcc.cuidarmais.Service.ContatoEmergenciaService;

import java.util.List;

@RestController
@RequestMapping("/contatoEmergencia")
public class ContatoEmergenciaController {

    private final ContatoEmergenciaService contatoEmergenciaService;

    @Autowired
    public ContatoEmergenciaController(ContatoEmergenciaService contatoEmergenciaService) {
        this.contatoEmergenciaService = contatoEmergenciaService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<ContatoEmergenciaEntity>> listarCuidados() {
        List<ContatoEmergenciaEntity> contatos = contatoEmergenciaService.listarContatos();
        return new ResponseEntity<>(contatos, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<ContatoEmergenciaEntity> salvarCuidado(@RequestBody ContatoEmergenciaEntity contatoEmergencia) {
        try {
            ContatoEmergenciaEntity novoContato = contatoEmergenciaService.salvarContato(contatoEmergencia);
            return new ResponseEntity<>(novoContato, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcontatoEmergencia}")
    public ResponseEntity<ContatoEmergenciaEntity> atualizarCuidador(@PathVariable int idcontatoEmergencia, @RequestBody ContatoEmergenciaEntity contatoAtualizado) {
        ContatoEmergenciaEntity contatoEmergencia = contatoEmergenciaService.buscarPorIdcontatoEmergencia(idcontatoEmergencia);
        if (contatoEmergencia != null) {
            contatoEmergencia.setNome(contatoAtualizado.getNome());
            contatoEmergencia.setTelefone(contatoAtualizado.getTelefone());
            contatoEmergencia.setParentesco(contatoAtualizado.getParentesco());
            ContatoEmergenciaEntity contatoEmergenciaAtualizadoDb = contatoEmergenciaService.salvarContato(contatoEmergencia);
            return new ResponseEntity<>(contatoEmergenciaAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcontatoEmergencia}")
    public ResponseEntity<Void> deletarContato(int idcontatoEmergencia) {
        try {
            contatoEmergenciaService.deletarContato(idcontatoEmergencia);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

