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

import tcc.cuidarmais.Entity.PacienteEntity;
import tcc.cuidarmais.Service.PacienteService;

@RestController
@RequestMapping("/paciente")
public class PacienteController {
    
    private final PacienteService pacienteService;

    @Autowired
    public PacienteController(PacienteService pacienteService) {
        this.pacienteService = pacienteService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<PacienteEntity>> listarTodosPacientes() {
        List<PacienteEntity> pacientes = pacienteService.listarTodosPacientes();
        return new ResponseEntity<>(pacientes, HttpStatus.OK);
    }

    @GetMapping("/{idcuidador}")
    public ResponseEntity<PacienteEntity> buscarPacientePorId(@PathVariable int idcuidador) {
        PacienteEntity paciente = pacienteService.buscarPacientePorId(idcuidador);
        System.out.println(idcuidador);
        if (paciente != null) {
            return new ResponseEntity<>(paciente, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @GetMapping("/por-cuidador/{idcuidador}")
    public ResponseEntity<List<PacienteEntity>> buscarPacientesPorIdCuidador(@PathVariable int idcuidador) {
        List<PacienteEntity> pacientes = pacienteService.buscarPacientesPorIdCuidador(idcuidador);
        return new ResponseEntity<>(pacientes, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<PacienteEntity> salvarPaciente(@RequestBody PacienteEntity paciente) {

        PacienteEntity pacienteSalvo = pacienteService.salvarPaciente(paciente);
        return new ResponseEntity<>(pacienteSalvo, HttpStatus.CREATED);
    }

    @PutMapping("/update/{idpaciente}")
    public ResponseEntity<PacienteEntity> atualizarPaciente(@PathVariable int idpaciente, @RequestBody PacienteEntity pacienteAtualizado) {
        PacienteEntity paciente = pacienteService.buscarPacientePorId(idpaciente);
        System.out.println(pacienteAtualizado.getEmail_responsavel());
        if (paciente != null) {
            paciente.setNome(pacienteAtualizado.getNome());
            paciente.setEmail_responsavel(pacienteAtualizado.getEmail_responsavel());
            paciente.setNome_responsavel(pacienteAtualizado.getNome_responsavel());
            paciente.setIdade(pacienteAtualizado.getIdade());
            paciente.setGenero(pacienteAtualizado.getGenero());
            PacienteEntity pacienteAtualizadoDb = pacienteService.salvarPaciente(paciente);
            return new ResponseEntity<>(pacienteAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{idpaciente}")
    public ResponseEntity<Void> deletarPacientePorId(@PathVariable int idpaciente) {
        System.out.println(idpaciente);
        pacienteService.deletarPacientePorId(idpaciente);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
