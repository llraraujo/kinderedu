package com.kinderedu.backend.config;

import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import com.kinderedu.backend.domain.entities.Professor;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.domain.entities.Turma;
import com.kinderedu.backend.domain.enums.ETipoAtividade;
import com.kinderedu.backend.domain.enums.ETurno;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.respository.AtividadeRespository;
import com.kinderedu.backend.respository.ProfessorRepository;
import com.kinderedu.backend.respository.ResponsavelRepository;
import com.kinderedu.backend.respository.TurmaRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

@Component
public class DataLoader implements CommandLineRunner {

    private final AlunoRepository alunoRepository;
    private final AtividadeRespository atividadeRepository;
    private final ProfessorRepository professorRepository;
    private final ResponsavelRepository responsavelRepository;
    private final TurmaRepository turmaRepository;

    public DataLoader(
            AlunoRepository alunoRepository,
            AtividadeRespository atividadeRepository,
            ProfessorRepository professorRepository,
            ResponsavelRepository responsavelRepository,
            TurmaRepository turmaRepository
    ) {
        this.alunoRepository = alunoRepository;
        this.atividadeRepository = atividadeRepository;
        this.professorRepository = professorRepository;
        this.responsavelRepository = responsavelRepository;
        this.turmaRepository = turmaRepository;
    }

    @Override
    public void run(String... args) {
        if (turmaRepository.count() > 0) {
            return;
        }

        Turma turma = new Turma();
        turma.setNome("Berçário A");
        turma.setAnoSerie("Berçário");
        turma.setCapacidade(20);
        turma.setTurno(ETurno.MANHA);
        turma = turmaRepository.save(turma);

        Professor professor = new Professor();
        professor.setNome("Profa. Carla");
        professor.setCpf("22222222222");
        professor.setTelefone("(11) 99999-2222");
        professor.setEmailInstitucional("carla@kinderedu.com");
        professor.setTurma(turma);
        professorRepository.save(professor);

        Responsavel mariaResponsavel = criarResponsavel("Maria Silva", "11111111111", "(11) 99999-1111", "maria.silva@email.com");
        Aluno maria = criarAluno("Maria Laura", "MAT-001", LocalDate.now().minusYears(2), turma, mariaResponsavel);
        criarAluno("Pedro Henrique", "MAT-002", LocalDate.now().minusYears(2).minusMonths(3), turma, criarResponsavel("João Costa", "33333333333", "(11) 99999-3333", "joao.costa@email.com"));
        criarAluno("Sofia Maria", "MAT-003", LocalDate.now().minusYears(2), turma, criarResponsavel("Ana Santos", "44444444444", "(11) 99999-4444", "ana.santos@email.com"));
        criarAluno("Lucas Gabriel", "MAT-004", LocalDate.now().minusYears(2), turma, criarResponsavel("Carla Souza", "55555555555", "(11) 99999-5555", "carla.souza@email.com"));

        criarAtividade(maria, ETipoAtividade.SONECA, "Soneca: 11:00 - 13:00");
        criarAtividade(maria, ETipoAtividade.SONECA, "Soneca: 14:30 - 15:00");
        criarAtividade(maria, ETipoAtividade.HIGIENE, "Troca de fralda");
        criarAtividade(maria, ETipoAtividade.ALIMENTACAO, "Almoço completo");
        criarAtividade(maria, ETipoAtividade.ALIMENTACAO, "Lanche da tarde");
    }

    private Responsavel criarResponsavel(String nome, String cpf, String telefone, String email) {
        Responsavel responsavel = new Responsavel();
        responsavel.setNome(nome);
        responsavel.setCpf(cpf);
        responsavel.setTelefone(telefone);
        responsavel.setEmail(email);
        return responsavelRepository.save(responsavel);
    }

    private Aluno criarAluno(String nome, String matricula, LocalDate dataNascimento, Turma turma, Responsavel responsavel) {
        Aluno aluno = new Aluno();
        aluno.setNome(nome);
        aluno.setMatricula(matricula);
        aluno.setDataNascimento(Date.from(dataNascimento.atStartOfDay(ZoneId.systemDefault()).toInstant()));
        aluno.setTurma(turma);
        aluno.setResponsavel(responsavel);
        return alunoRepository.save(aluno);
    }

    private void criarAtividade(Aluno aluno, ETipoAtividade tipo, String observacao) {
        Atividade atividade = new Atividade();
        atividade.setAluno(aluno);
        atividade.setTipo(tipo);
        atividade.setObservacao(observacao);
        atividade.setData(new Date());
        atividadeRepository.save(atividade);
    }
}
