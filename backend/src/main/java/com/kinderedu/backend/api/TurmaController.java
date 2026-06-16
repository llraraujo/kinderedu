package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.dto.AlunoListagemMobileDTO;
import com.kinderedu.backend.domain.dto.TurmaCadastroDTO;
import com.kinderedu.backend.domain.dto.TurmaListagemDTO;
import com.kinderedu.backend.services.AlunoService;
import com.kinderedu.backend.services.ProfessorService;
import com.kinderedu.backend.services.TurmaService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/turmas")
@CrossOrigin("*")
public class TurmaController  extends BaseController{

    private final TurmaService turmaService;

    @Autowired
    public TurmaController(TurmaService turmaService){
        this.turmaService = turmaService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<TurmaListagemDTO>> index() {
        var turmas = turmaService.todasAsTurmas();
        return ResponseEntity.ok(turmas);
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/{professorCpf}")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AlunoListagemMobileDTO>> alunosPorCpfProfessor(@PathVariable String professorCpf) {
        var alunos = turmaService.alunosPorCpfProfessor(professorCpf);
        return ResponseEntity.ok(alunos);
    }


    @RequestMapping(method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<TurmaListagemDTO> create(@RequestBody TurmaCadastroDTO turmaCadastroDTO){
        var turma = this.turmaService.create(turmaCadastroDTO);
        URI uri = createRouteUri(turma.getIdTurma());
        return ResponseEntity.created(uri).body(new TurmaListagemDTO(turma));
    }

}
