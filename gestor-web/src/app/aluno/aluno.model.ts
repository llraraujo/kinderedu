export interface Aluno {
  id?: string;
  // Dados do Aluno
  nomeCompleto: string;
  matricula: string;
  dataNascimento: string;
  turmaId: string;
  // Dados do Responsável
  nomeResponsavel: string;
  cpf: string;
  email: string;
  telefone: string;
}
