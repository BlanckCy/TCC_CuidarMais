package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.RotinaEntity;
import tcc.cuidarmais.Service.RotinaService;

import java.util.List;

@RestController
@RequestMapping("/rotina")
public class RotinaController {

    private final RotinaService rotinaService;

    @Autowired
    public RotinaController(RotinaService rotinaService) {
        this.rotinaService = rotinaService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<RotinaEntity>> listar() {
        List<RotinaEntity> cuidados = rotinaService.listar();
        return new ResponseEntity<>(cuidados, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{tipo}")
    public ResponseEntity<List<RotinaEntity>> listarPorIdpacienteTipo(@PathVariable int idpaciente, @PathVariable int tipo) {
        try {
            List<RotinaEntity> cuidados = rotinaService.buscarPorIdpacienteTipo(idpaciente,tipo);
            System.err.println(cuidados);
            return new ResponseEntity<>(cuidados, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }        
    }

    @PostMapping("/create")
    public ResponseEntity<RotinaEntity> salvar(@RequestBody RotinaEntity cuidado) {
        try {
            RotinaEntity novoCuidado = rotinaService.salvar(cuidado);
            return new ResponseEntity<>(novoCuidado, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idrotina}")
    public ResponseEntity<RotinaEntity> atualizar(@PathVariable int idrotina, @RequestBody RotinaEntity cuidadoAtualizado) {
        RotinaEntity cuidado = rotinaService.buscarPorIdrotina(idrotina);
        if (cuidado != null) {
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setRealizado(cuidadoAtualizado.isRealizado());
            cuidado.setTipo_cuidado(cuidadoAtualizado.getTipo_cuidado());
            cuidado.setCuidado(cuidadoAtualizado.getCuidado());

            RotinaEntity cuidadorAtualizadoDb = rotinaService.salvar(cuidado);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idrotina}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable int idpaciente, int idrotina) {
        try {
            rotinaService.deletar(idrotina);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

