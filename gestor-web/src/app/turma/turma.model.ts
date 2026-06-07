export interface Turma {
  id?: string;
  nome: string;
  anoSerie: string;
  turno: 'Manhã' | 'Tarde' | 'Integral';
  capacidade: number;
}
