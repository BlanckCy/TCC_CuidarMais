package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadoSinaisVitaisEntity;
import tcc.cuidarmais.Service.CuidadoSinaisVitaisService;

import java.util.List;

@RestController
@RequestMapping("/cuidado-sinaisvitais")
public class CuidadoSinaisVitaisController {

    private final CuidadoSinaisVitaisService cuidadosinaisvitaisservice;

    @Autowired
    public CuidadoSinaisVitaisController(CuidadoSinaisVitaisService cuidadosinaisvitaisservice) {
        this.cuidadosinaisvitaisservice = cuidadosinaisvitaisservice;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadoSinaisVitaisEntity>> listarCuidados() {
        List<CuidadoSinaisVitaisEntity> cuidado = cuidadosinaisvitaisservice.listar();
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/lista/{idpaciente}/{data}")
    public ResponseEntity<List<CuidadoSinaisVitaisEntity>> listarCuidadoIdpacienteData(@PathVariable int idpaciente, @PathVariable String data) {
        List<CuidadoSinaisVitaisEntity> cuidado = cuidadosinaisvitaisservice.listaPorClienteData(idpaciente,data);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @GetMapping("/{idcuidado_sinaisvitais}")
    public ResponseEntity<CuidadoSinaisVitaisEntity> buscarContatosPoridcontato_emergencia(@PathVariable int idcuidado_sinaisvitais) {
        CuidadoSinaisVitaisEntity contato = cuidadosinaisvitaisservice.buscarPorIdcuidado_mudancadecubito(idcuidado_sinaisvitais);
        if (contato != null) {
            return ResponseEntity.ok(contato);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/por-paciente/{idpaciente}")
    public ResponseEntity<List<CuidadoSinaisVitaisEntity>> buscarContatosPorIdPaciente(@PathVariable int idpaciente) {
        List<CuidadoSinaisVitaisEntity> cuidado = cuidadosinaisvitaisservice.buscarPorIdPaciente(idpaciente);
        return new ResponseEntity<>(cuidado, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadoSinaisVitaisEntity> salvar(@RequestBody CuidadoSinaisVitaisEntity cuidado) {
        try {
            CuidadoSinaisVitaisEntity novoContato = cuidadosinaisvitaisservice.salvar(cuidado);
            return new ResponseEntity<>(novoContato, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @PutMapping("/update/{idcuidado_sinaisvitais}")
    public ResponseEntity<CuidadoSinaisVitaisEntity> atualizar(@PathVariable int idcuidado_sinaisvitais, @RequestBody CuidadoSinaisVitaisEntity cuidadoAtualizado) {
        CuidadoSinaisVitaisEntity cuidado = cuidadosinaisvitaisservice.buscarPorIdcuidado_mudancadecubito(idcuidado_sinaisvitais);
        if (cuidado != null) {
            cuidado.setPressao_sistolica(cuidadoAtualizado.getPressao_sistolica());
            cuidado.setPressao_diastolica(cuidadoAtualizado.getPressao_diastolica());
            cuidado.setTemperatura(cuidadoAtualizado.getTemperatura());
            cuidado.setFrequencia_respiratoria(cuidadoAtualizado.getFrequencia_respiratoria());
            cuidado.setFrequencia_cardiaca(cuidadoAtualizado.getFrequencia_cardiaca());
            cuidado.setData_hora(cuidadoAtualizado.getData_hora());
            cuidado.setDescricao(cuidadoAtualizado.getDescricao());
            cuidado.setIdpaciente(cuidadoAtualizado.getIdpaciente());
            
            CuidadoSinaisVitaisEntity contatoEmergenciaAtualizadoDb = cuidadosinaisvitaisservice.salvar(cuidado);
            return new ResponseEntity<>(contatoEmergenciaAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idcuidado_sinaisvitais}")
    public ResponseEntity<Void> deletar(@PathVariable int idcuidado_sinaisvitais) {
        try {
            cuidadosinaisvitaisservice.deletar(idcuidado_sinaisvitais);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

