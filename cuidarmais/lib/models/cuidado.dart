class Cuidado {
  int? idcuidado;
  DateTime? data;
  bool? realizou;
  int? tipoCuidado;

  Cuidado({idcuidado, data, realizou, tipoCuidadoNumero});

  String especificarTipoCuidado() {
    switch (tipoCuidado) {
      case 1:
        return 'Refeicao';
      case 2:
        return 'Sinais Vitais';
      case 3:
        return 'Atividade Fisica';
      case 4:
        return 'Equipamentos Medicos';
      case 5:
        return 'Higiene';
      case 6:
        return 'Medicacao';
      case 7:
        return 'Tratamento de Feridas';
      default:
        return '';
    }
  }
}
