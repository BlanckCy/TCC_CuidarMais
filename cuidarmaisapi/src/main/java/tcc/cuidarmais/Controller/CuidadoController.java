package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoEntity;
import tcc.cuidarmais.Service.CuidadoService;

import java.util.List;

@RestController
@RequestMapping("/cuidado")
public class CuidadoController {

    private final CuidadoService cuidadoService;

    @Autowired
    public CuidadoController(CuidadoService cuidadoService) {
        this.cuidadoService = cuidadoService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoEntity>> listarCuidados() {
        List<CuidadoEntity> cuidados = cuidadoService.listarCuidados();
        return new ResponseEntity<>(cuidados, HttpStatus.OK);
    }

    @GetMapping("/lista/{tipo}/{data}")
    public ResponseEntity<List<CuidadoEntity>> listarCuidadosPorTipoData(@PathVariable int tipo, @PathVariable String data) {
        try {
            List<CuidadoEntity> cuidados = cuidadoService.listarCuidadosPorTipoData(tipo,data);
            System.err.println(cuidados);
            return new ResponseEntity<>(cuidados, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }        
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoEntity> salvarCuidado(@RequestBody CuidadoEntity cuidado) {
        try {
            CuidadoEntity novoCuidado = cuidadoService.salvarCuidado(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado}")
    public ResponseEntity<CuidadoEntity> atualizarCuidado(@PathVariable int idcuidado, @RequestBody CuidadoEntity cuidadoAtualizado) {
        CuidadoEntity cuidado = cuidadoService.buscarPorIdcuidado(idcuidado);
        if (cuidado != null) {
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setDescricao(cuidadoAtualizado.getDescricao());
            cuidado.setHorario_realizado(cuidadoAtualizado.getHorario_realizado());
            cuidado.setAvaliacao(cuidadoAtualizado.isAvaliacao());
            CuidadoEntity cuidadorAtualizadoDb = cuidadoService.salvarCuidado(cuidado);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable int idpaciente, int idcuidado) {
        try {
            cuidadoService.deletarCuidado(idcuidado);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

