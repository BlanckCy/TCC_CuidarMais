package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoRefeicaoEntity;
import tcc.cuidarmais.Service.CuidadoRefeicaoService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-refeicao")
public class CuidadoRefeicaoController {

    private final CuidadoRefeicaoService cuidadorefeicaoservice;

    @Autowired
    public CuidadoRefeicaoController(CuidadoRefeicaoService cuidadorefeicaoservice) {
        this.cuidadorefeicaoservice = cuidadorefeicaoservice;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoRefeicaoEntity>> listarCuidados() {
        List<CuidadoRefeicaoEntity> cuidado = cuidadorefeicaoservice.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{idrotina}")
    public ResponseEntity<List<CuidadoRefeicaoEntity>> listarPorIdpacienteIdrotina(@PathVariable int idpaciente, @PathVariable int idrotina) {
        List<CuidadoRefeicaoEntity> cuidado = cuidadorefeicaoservice.listarPorIdpacienteIdrotina(idpaciente,idrotina);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/{idcuidado_refeicao}")
    public ResponseEntity<CuidadoRefeicaoEntity> buscarPorIdcuidado_refeicao(@PathVariable int idcuidado_refeicao) {
        CuidadoRefeicaoEntity cuidado = cuidadorefeicaoservice.buscarPorIdcuidado_refeicao(idcuidado_refeicao);
        if (cuidado != null) {
            return ResponseEntity.ok(cuidado);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<CuidadoRefeicaoEntity>> buscarPorIdPaciente(@PathVariable int idpaciente) {
        List<CuidadoRefeicaoEntity> cuidado = cuidadorefeicaoservice.buscarPorIdPaciente(idpaciente);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoRefeicaoEntity> salvar(@RequestBody CuidadoRefeicaoEntity cuidado) {
        try {
            CuidadoRefeicaoEntity novoCuidado = cuidadorefeicaoservice.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_refeicao}")
    public ResponseEntity<CuidadoRefeicaoEntity> atualizar(@PathVariable int idcuidado_refeicao, @RequestBody CuidadoRefeicaoEntity cuidadoAtualizado) {
        CuidadoRefeicaoEntity cuidado = cuidadorefeicaoservice.buscarPorIdcuidado_refeicao(idcuidado_refeicao);

        if (cuidado != null) {
            cuidado.setAvaliacao_cafe(cuidadoAtualizado.isAvaliacao_cafe());
            cuidado.setHora_cafe(cuidadoAtualizado.getHora_cafe());
            cuidado.setDescricao_cafe(cuidadoAtualizado.getDescricao_cafe());

            cuidado.setAvaliacao_almoco(cuidadoAtualizado.isAvaliacao_almoco());
            cuidado.setHora_almoco(cuidadoAtualizado.getHora_almoco());
            cuidado.setDescricao_almoco(cuidadoAtualizado.getDescricao_almoco());
            
            cuidado.setAvaliacao_jantar(cuidadoAtualizado.isAvaliacao_jantar());
            cuidado.setHora_jantar(cuidadoAtualizado.getHora_jantar());
            cuidado.setDescricao_jantar(cuidadoAtualizado.getDescricao_jantar());
            
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setIdpaciente(cuidadoAtualizado.getIdpaciente());

            CuidadoRefeicaoEntity cuidadoAtualizadoDb = cuidadorefeicaoservice.salvar(cuidado);
            return new ResponseEntity<>(cuidadoAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_refeicao}")
    public ResponseEntity<Void> deletar(@PathVariable int idcuidado_refeicao) {
        try {
            cuidadorefeicaoservice.deletar(idcuidado_refeicao);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

