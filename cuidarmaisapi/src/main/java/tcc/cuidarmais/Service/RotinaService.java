package tcc.cuidarmais.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tcc.cuidarmais.Entity.RotinaEntity;
import tcc.cuidarmais.Repository.RotinaRepository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class RotinaService {

    private final RotinaRepository cuidadoRepository;

    @Autowired
    public RotinaService(RotinaRepository cuidadoRepository) {
        this.cuidadoRepository = cuidadoRepository;
    }

    public List<RotinaEntity> listar() {
        return cuidadoRepository.findAll();
    }

    public Map<String, Object> relatorioRotina(int idpaciente, String data) {
        List<Object[]> results = cuidadoRepository.relatorioRotina(idpaciente, data);
        Map<String, Object> finalResult = new LinkedHashMap<>();
        Map<String, List<Map<String, Object>>> mappedResults = new LinkedHashMap<>();
    
        for (Object[] result : results) {
            String tipoCuidado = String.valueOf(result[0]);
            Map<String, Object> mappedResult = new LinkedHashMap<>();
    
            // Método auxiliar para mapear os resultados conforme o tipo de cuidado
            mapResultByType(tipoCuidado, result, mappedResult);
    
            // Verifica se já existe uma lista para o tipo de cuidado atual e a cria, se necessário
            List<Map<String, Object>> listaRotinas = mappedResults.getOrDefault(tipoCuidado, new ArrayList<>());
            listaRotinas.add(mappedResult);
            mappedResults.put(tipoCuidado, listaRotinas);
        }

        finalResult.put("cuidados", mappedResults);
    
        return finalResult;
    }
    
    private void mapResultByType(String tipoCuidado, Object[] result, Map<String, Object> mappedResult) {
        mappedResult.put("tipo_cuidado", tipoCuidado);
    
        switch (tipoCuidado) {
            case "1":
                mappedResult.put("cuidado", "Refeição");
                mappedResult.put("avaliacao_cafe", getBooleanValue(result, 2));
                mappedResult.put("hora_cafe", getStringValue(result, 3));
                mappedResult.put("descricao_cafe", getStringValue(result, 4));
                mappedResult.put("avaliacao_almoco", getBooleanValue(result, 5));
                mappedResult.put("hora_almoco", getStringValue(result, 6));
                mappedResult.put("descricao_almoco", getStringValue(result, 7));
                mappedResult.put("descricao_jantar", getStringValue(result, 8));
                mappedResult.put("avaliacao_jantar", getBooleanValue(result, 9));
                mappedResult.put("hora_jantar", getStringValue(result, 10));
                break;
            case "2":
                mappedResult.put("cuidado", "Sinais Vitais");
                mappedResult.put("pressao_sistolica", getIntegerValue(result, 11));
                mappedResult.put("pressao_diastolica", getIntegerValue(result, 12));
                mappedResult.put("temperatura", getStringValue(result, 13));
                mappedResult.put("frequencia_respiratoria", getStringValue(result, 14));
                mappedResult.put("frequencia_cardiaca", getStringValue(result, 15));
                mappedResult.put("descricao_sinais_vitais", getStringValue(result, 16));
                break;
            case "3":
                mappedResult.put("cuidado", "Atividade Física");
                mappedResult.put("avaliacao_atividade_fisica", getBooleanValue(result, 17));
                mappedResult.put("hora_atividade_fisica", getStringValue(result, 18));
                mappedResult.put("descricao_atividade_fisica", getStringValue(result, 19));
                break;
            case "4":
                mappedResult.put("cuidado", "Higiene");
                mappedResult.put("tarefa_higiene", getStringValue(result, 20));
                mappedResult.put("hora_higiene", getStringValue(result, 21));
                break;
            case "5":
                mappedResult.put("cuidado", "Medicação");
                mappedResult.put("medicamento", getStringValue(result, 22));
                mappedResult.put("realizado_medicamento", getBooleanValue(result, 23));
                mappedResult.put("data_hora_medicamento", getStringValue(result, 24));
                break;
            case "6":
                mappedResult.put("cuidado", "Mudança Decúbito");
                mappedResult.put("mudanca_decubito", getStringValue(result, 25));
                mappedResult.put("hora_mudancadecubito", getStringValue(result, 26));
                break;
        }
    }
    
    private Boolean getBooleanValue(Object[] result, int index) {
        if (result != null && result.length > index && result[index] != null) {
            return Boolean.valueOf(result[index].toString());
        }
        return null;
    }
    
    private Integer getIntegerValue(Object[] result, int index) {
        if (result != null && result.length > index && result[index] != null) {
            return Integer.valueOf(result[index].toString());
        }
        return null;
    }
    
    private String getStringValue(Object[] result, int index) {
        if (result != null && result.length > index && result[index] != null) {
            return result[index].toString();
        }
        return null;
    }      

    public List<RotinaEntity> buscarPorIdpacienteTipo(int idpaciente, int tipo) {
        return cuidadoRepository.buscarPorIdpacienteTipo(idpaciente,tipo);
    }

    public List<RotinaEntity> buscarPorIdpacienteRotinaAtual(int idpaciente) {
        return cuidadoRepository.buscarPorIdpacienteRotinaAtual(idpaciente);
    }

    public RotinaEntity buscarPorIdrotina(int idrotina) {
        return cuidadoRepository.findByIdrotina(idrotina);
    }

    public RotinaEntity salvar(RotinaEntity cuidado) {
        return cuidadoRepository.save(cuidado);
    }

    public void deletar(int id) {
        cuidadoRepository.deleteById(id);
    }
}
