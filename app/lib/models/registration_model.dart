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
}