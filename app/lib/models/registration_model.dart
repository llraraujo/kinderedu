enum ETipoAtividade { ALIMENTACAO, SONECA, HIGIENE }

class RegistrationModel {
  final int alunoId;
  final ETipoAtividade tipo;
  final String? observacao;
  final String? inicioSoneca;
  final String? fimSoneca;

  RegistrationModel({
    required this.alunoId,
    required this.tipo,
    this.observacao,
    this.inicioSoneca,
    this.fimSoneca,
  });

  RegistrationModel.fromJson(Map<String, dynamic> json): 
    alunoId = json['alunoId'], 
    tipo = json['tipo'], 
    observacao = json['observacao'], 
    inicioSoneca = json['inicioSoneca'], 
    fimSoneca = json['fimSoneca'];

  

  static Map<String, dynamic> toJson(RegistrationModel value) =>
    {
      'alunoId': value.alunoId,
      'tipo': value.tipo.name,
      'observacao': value.observacao,
      'inicioSoneca': value.inicioSoneca,
      'fimSoneca': value.fimSoneca
    };
  
}