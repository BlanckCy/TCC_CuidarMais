package tcc.cuidarmais.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import tcc.cuidarmais.Entity.CuidadorEntity;
import tcc.cuidarmais.Service.CuidadorService;

import java.util.List;

@RestController
@RequestMapping("/cuidador")
public class CuidadorController {

    private final CuidadorService cuidadorService;

    @Autowired
    public CuidadorController(CuidadorService cuidadorService) {
        this.cuidadorService = cuidadorService;
    }

    @GetMapping("/lista")
    public ResponseEntity<List<CuidadorEntity>> listarCuidadores() {
        List<CuidadorEntity> cuidadores = cuidadorService.listarCuidadores();
        return new ResponseEntity<>(cuidadores, HttpStatus.OK);
    }

    @GetMapping("/{email}")
    public ResponseEntity<CuidadorEntity> encontrarCuidador(@PathVariable String email) {
        System.out.println(email);
        CuidadorEntity cuidador = cuidadorService.encontrarCuidadorPorEmail(email);
        if (cuidador != null) {
            return new ResponseEntity<>(cuidador, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @PostMapping("/create")
    public ResponseEntity<CuidadorEntity> criarCuidador(@RequestBody CuidadorEntity cuidador) {
        System.out.println(cuidador.getEmail());

        CuidadorEntity cuidadorExistente = cuidadorService.encontrarCuidadorPorEmail(cuidador.getEmail());
        System.out.println(cuidadorExistente);

        if (cuidadorExistente == null) {
            CuidadorEntity novoCuidador = cuidadorService.salvarCuidador(cuidador);
            return new ResponseEntity<>(novoCuidador, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }   

    @PostMapping("/login")
    public ResponseEntity<CuidadorEntity> fazerLogin(@RequestBody CuidadorEntity cuidador) {
        String email = cuidador.getEmail();
        String senha = cuidador.getSenha(); 

        System.out.println(email);
        System.out.println(senha);

        CuidadorEntity cuidadorValidado  = cuidadorService.validateLogin(email, senha);
        if (cuidadorValidado  != null) {
            return new ResponseEntity<>(cuidadorValidado , HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }

    @PutMapping("/update/{email}")
    public ResponseEntity<CuidadorEntity> atualizarCuidador(@PathVariable String email, @RequestBody CuidadorEntity cuidadorAtualizado) {
        CuidadorEntity cuidador = cuidadorService.encontrarCuidadorPorEmail(email);
        if (cuidador != null) {
            cuidador.setIdade(cuidadorAtualizado.getIdade());
            cuidador.setEmail(cuidadorAtualizado.getEmail());
            cuidador.setNome(cuidadorAtualizado.getNome());
            cuidador.setSenha(cuidadorAtualizado.getSenha());
            cuidador.setTelefone(cuidadorAtualizado.getTelefone());
            cuidador.setGenero(cuidadorAtualizado.getGenero());
            CuidadorEntity cuidadorAtualizadoDb = cuidadorService.salvarCuidador(cuidador);
            return new ResponseEntity<>(cuidadorAtualizadoDb, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{email}/{id}")
    public ResponseEntity<Void> deletarCuidador(@PathVariable String email, int id) {
        CuidadorEntity cuidador = cuidadorService.encontrarCuidadorPorEmail(email);
        if (cuidador != null) {
            cuidadorService.deletarCuidador(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}

