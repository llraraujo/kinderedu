export interface Turma {
  id?: number;
  nome: string;
  anoSerie: string;
  turno: 'MANHA' | 'TARDE' | 'INTEGRAL';
  capacidade: number;
  professor?: string;
  nomeProfessor?: string;
}
