package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoHigieneEntity;
import tcc.cuidarmais.Service.CuidadoHigieneService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-higiene")
public class CuidadoHigieneController {

    private final CuidadoHigieneService cuidadohigieneservice;

    @Autowired
    public CuidadoHigieneController(CuidadoHigieneService cuidadohigieneservice) {
        this.cuidadohigieneservice = cuidadohigieneservice;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoHigieneEntity>> listarCuidados() {
        List<CuidadoHigieneEntity> cuidado = cuidadohigieneservice.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{idrotina}")
    public ResponseEntity<List<CuidadoHigieneEntity>> listarCuidadoIdpacienteIdrotina(@PathVariable int idpaciente, @PathVariable int idrotina) {
        List<CuidadoHigieneEntity> cuidado = cuidadohigieneservice.listarCuidadoIdpacienteIdrotina(idpaciente,idrotina);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/{idcuidado_higiene}")
    public ResponseEntity<CuidadoHigieneEntity> buscarPorIdcuidado_higiene(@PathVariable int idcuidado_higiene) {
        CuidadoHigieneEntity cuidado = cuidadohigieneservice.buscarPorIdcuidado_higiene(idcuidado_higiene);
        if (cuidado != null) {
            return ResponseEntity.ok(cuidado);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<CuidadoHigieneEntity>> buscarPorIdPaciente(@PathVariable int idpaciente) {
        List<CuidadoHigieneEntity> cuidado = cuidadohigieneservice.buscarPorIdPaciente(idpaciente);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoHigieneEntity> salvar(@RequestBody CuidadoHigieneEntity cuidado) {
        try {
            CuidadoHigieneEntity novoCuidado = cuidadohigieneservice.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_higiene}")
    public ResponseEntity<CuidadoHigieneEntity> atualizar(@PathVariable int idcuidado_higiene, @RequestBody CuidadoHigieneEntity cuidadoAtualizado) {
        CuidadoHigieneEntity cuidado = cuidadohigieneservice.buscarPorIdcuidado_higiene(idcuidado_higiene);
        if (cuidado != null) {
            cuidado.setTarefa(cuidadoAtualizado.getTarefa());
            cuidado.setHora(cuidadoAtualizado.getHora());
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setIdpaciente(cuidadoAtualizado.getIdpaciente());

            CuidadoHigieneEntity cuidadoAtualizadoDb = cuidadohigieneservice.salvar(cuidado);
            return new ResponseEntity<>(cuidadoAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_higiene}")
    public ResponseEntity<Void> deletar(@PathVariable int idcuidado_higiene) {
        try {
            cuidadohigieneservice.deletar(idcuidado_higiene);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

