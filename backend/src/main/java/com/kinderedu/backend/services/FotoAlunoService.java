package com.kinderedu.backend.services;

import com.kinderedu.backend.domain.dto.FotoAlunoListagemDTO;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.FotoAluno;
import com.kinderedu.backend.respository.AlunoRepository;
import com.kinderedu.backend.respository.FotoAlunoRepository;
import jakarta.transaction.Transactional;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class FotoAlunoService {

    private final FotoAlunoRepository fotoAlunoRepository;
    private final AlunoRepository alunoRepository;

    public FotoAlunoService(FotoAlunoRepository fotoAlunoRepository, AlunoRepository alunoRepository) {
        this.fotoAlunoRepository = fotoAlunoRepository;
        this.alunoRepository = alunoRepository;
    }

    @Transactional
    public FotoAlunoListagemDTO cadastrarFoto(
            Long alunoId,
            String cpfProfessor,
            MultipartFile arquivo,
            String descricao,
            LocalDateTime dataHora
    ) {
        if (arquivo == null || arquivo.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "A foto enviada nao pode estar vazia.");
        }

        Aluno aluno = recuperarAlunoDoProfessor(alunoId, cpfProfessor);

        FotoAluno foto = new FotoAluno();
        foto.setAluno(aluno);
        foto.setDescricao(descricao);
        foto.setNomeArquivo(arquivo.getOriginalFilename());
        foto.setContentType(resolverContentType(arquivo));
        foto.setDataHora(dataHora != null ? dataHora : LocalDateTime.now());

        try {
            foto.setArquivo(arquivo.getBytes());
        } catch (IOException ex) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Nao foi possivel ler a foto enviada.", ex);
        }

        foto = fotoAlunoRepository.save(foto);
        return new FotoAlunoListagemDTO(foto, montarImageUrl(alunoId, foto.getIdFoto(), aluno.getResponsavel().getCpf()));
    }

    @Transactional
    public List<FotoAlunoListagemDTO> listarFotosPorDia(Long alunoId, String cpfResponsavel, LocalDate data) {
        recuperarAlunoDoResponsavel(alunoId, cpfResponsavel);

        LocalDateTime inicio = data.atStartOfDay();
        LocalDateTime fim = data.plusDays(1).atStartOfDay();

        return fotoAlunoRepository
                .findByAluno_IdAlunoAndAluno_Responsavel_CpfAndDataHoraBetweenOrderByDataHoraAsc(
                        alunoId,
                        cpfResponsavel,
                        inicio,
                        fim
                )
                .stream()
                .map(foto -> new FotoAlunoListagemDTO(foto, montarImageUrl(alunoId, foto.getIdFoto(), cpfResponsavel)))
                .toList();
    }

    @Transactional
    public FotoAluno recuperarArquivo(Long alunoId, Long fotoId, String cpfResponsavel) {
        return fotoAlunoRepository
                .findByIdFotoAndAluno_IdAlunoAndAluno_Responsavel_Cpf(fotoId, alunoId, cpfResponsavel)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Foto nao encontrada para este responsavel."));
    }

    private Aluno recuperarAlunoDoResponsavel(Long alunoId, String cpfResponsavel) {
        Aluno aluno = alunoRepository.findById(alunoId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno nao encontrado."));

        if (aluno.getResponsavel() == null || !cpfResponsavel.equals(aluno.getResponsavel().getCpf())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Responsavel nao autorizado para este aluno.");
        }

        return aluno;
    }

    private Aluno recuperarAlunoDoProfessor(Long alunoId, String cpfProfessor) {
        Aluno aluno = alunoRepository.findById(alunoId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Aluno nao encontrado."));

        if (aluno.getTurma() == null
                || aluno.getTurma().getProfessor() == null
                || !cpfProfessor.equals(aluno.getTurma().getProfessor().getCpf())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Professor nao autorizado para este aluno.");
        }

        return aluno;
    }

    private String montarImageUrl(Long alunoId, Long fotoId, String cpfResponsavel) {
        return "/alunos/" + alunoId + "/fotos/" + fotoId + "/arquivo?cpfResponsavel=" + cpfResponsavel;
    }

    private String resolverContentType(MultipartFile arquivo) {
        if (arquivo.getContentType() != null && !arquivo.getContentType().isBlank()) {
            return arquivo.getContentType();
        }

        String nomeArquivo = arquivo.getOriginalFilename();
        if (nomeArquivo == null) {
            return "image/jpeg";
        }

        String nomeNormalizado = nomeArquivo.toLowerCase();
        if (nomeNormalizado.endsWith(".png")) {
            return "image/png";
        }
        if (nomeNormalizado.endsWith(".webp")) {
            return "image/webp";
        }

        return "image/jpeg";
    }
}
