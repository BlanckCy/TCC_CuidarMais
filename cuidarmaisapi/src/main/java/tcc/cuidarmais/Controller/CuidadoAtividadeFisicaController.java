package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoAtividadeFisicaEntity;
import tcc.cuidarmais.Service.CuidadoAtividadeFisicaService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-atividadefisica")
public class CuidadoAtividadeFisicaController {

    private final CuidadoAtividadeFisicaService cuidadoatividadefisicaservice;

    @Autowired
    public CuidadoAtividadeFisicaController(CuidadoAtividadeFisicaService cuidadoatividadefisicaservice) {
        this.cuidadoatividadefisicaservice = cuidadoatividadefisicaservice;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoAtividadeFisicaEntity>> listarCuidados() {
        List<CuidadoAtividadeFisicaEntity> cuidado = cuidadoatividadefisicaservice.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{idrotina}")
    public ResponseEntity<List<CuidadoAtividadeFisicaEntity>> listarCuidadoIdpacienteIdrotina(@PathVariable int idpaciente, @PathVariable int idrotina) {
        List<CuidadoAtividadeFisicaEntity> cuidado = cuidadoatividadefisicaservice.listarCuidadoIdpacienteIdrotina(idpaciente,idrotina);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/{idcuidado_atividadefisica}")
    public ResponseEntity<CuidadoAtividadeFisicaEntity> buscarPorIdcuidado_atividadefisica(@PathVariable int idcuidado_atividadefisica) {
        CuidadoAtividadeFisicaEntity cuidado = cuidadoatividadefisicaservice.buscarPorIdcuidado_atividadefisica(idcuidado_atividadefisica);
        if (cuidado != null) {
            return ResponseEntity.ok(cuidado);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<CuidadoAtividadeFisicaEntity>> buscarPorIdPaciente(@PathVariable int idpaciente) {
        List<CuidadoAtividadeFisicaEntity> cuidado = cuidadoatividadefisicaservice.buscarPorIdPaciente(idpaciente);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoAtividadeFisicaEntity> salvar(@RequestBody CuidadoAtividadeFisicaEntity cuidado) {
        try {
            CuidadoAtividadeFisicaEntity novoCuidado = cuidadoatividadefisicaservice.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_atividadefisica}")
    public ResponseEntity<CuidadoAtividadeFisicaEntity> atualizar(@PathVariable int idcuidado_atividadefisica, @RequestBody CuidadoAtividadeFisicaEntity cuidadoAtualizado) {
        CuidadoAtividadeFisicaEntity cuidado = cuidadoatividadefisicaservice.buscarPorIdcuidado_atividadefisica(idcuidado_atividadefisica);
        if (cuidado != null) {
            cuidado.setAvaliacao(cuidadoAtualizado.isAvaliacao());
            cuidado.setHora(cuidadoAtualizado.getHora());
            cuidado.setDescricao(cuidadoAtualizado.getDescricao());
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setIdpaciente(cuidadoAtualizado.getIdpaciente());

            CuidadoAtividadeFisicaEntity cuidadoAtualizadoDb = cuidadoatividadefisicaservice.salvar(cuidado);
            return new ResponseEntity<>(cuidadoAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_atividadefisica}")
    public ResponseEntity<Void> deletar(@PathVariable int idcuidado_atividadefisica) {
        try {
            cuidadoatividadefisicaservice.deletar(idcuidado_atividadefisica);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

