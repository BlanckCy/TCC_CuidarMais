package tcc.cuidarmais.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.PacienteEntity;
import tcc.cuidarmais.Repository.PacienteRepository;

@Service
public class PacienteService {
    private final PacienteRepository pacienteRepository;

    @Autowired
    public PacienteService(PacienteRepository pacienteRepository) {
        this.pacienteRepository = pacienteRepository;
    }

    public PacienteEntity salvarPaciente(PacienteEntity paciente) {
        return pacienteRepository.save(paciente);
    }

    public List<PacienteEntity> listarTodosPacientes() {
        return pacienteRepository.findAll();
    }

    public List<PacienteEntity> buscarPacientesPorIdCuidador(int idCuidador) {
        return pacienteRepository.findByCuidadorId(idCuidador);
    }

    public PacienteEntity buscarPacientePorId(int idPaciente) {
        Optional<PacienteEntity> pacienteOptional = pacienteRepository.findById(idPaciente);
        return pacienteOptional.orElse(null); 
    }    

    public void deletarPacientePorId(int idPaciente) {
        pacienteRepository.deleteById(idPaciente);
    }
}
