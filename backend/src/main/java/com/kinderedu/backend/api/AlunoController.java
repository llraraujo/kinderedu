package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.dto.*;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import com.kinderedu.backend.services.AlunoService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/alunos")
@CrossOrigin("*")
public class AlunoController extends  BaseController{

    private final AlunoService alunoService;

    public  AlunoController(@Autowired AlunoService alunoService) {
        this.alunoService = alunoService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AlunoListagemDTO>> index() {
        var alunos = alunoService.todosOsAlunos();
        return ResponseEntity.ok(alunos);
    }

    @RequestMapping(method =  RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE,produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<Aluno> create(@RequestBody  AlunoCadastroDTO alunoDTO) {
        Aluno aluno = this.alunoService.create(alunoDTO);
        URI uri = createRouteUri(aluno.getIdAluno());
        return ResponseEntity.created(uri).build();
    }

    @RequestMapping(method =  RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE,produces = MediaType.APPLICATION_JSON_VALUE, path = "/{alunoId}/atividade")
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<Atividade> cadastrarAtividade(@PathVariable Long alunoId, @RequestBody AtividadeCadastroDTO ativadadeDTO){
        Atividade atividade = this.alunoService.cadastrarAtividade(alunoId, ativadadeDTO);
        URI uri = createRouteUri(atividade.getIdAtividade());
        return ResponseEntity.created(uri).build();
    }

    @RequestMapping(method =  RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/atividades/{alunoId}")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AtividadeDashboardDTO>> sumarioAtividades(@PathVariable Long alunoId){
        var atividades = this.alunoService.recuperaAtividadesDashboard(alunoId);
        return ResponseEntity.ok(atividades);
    }

    @RequestMapping(method =  RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/{cpfResponsavel}")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<AlunoProfileDTO> alunosPorCpfResponsavel(@PathVariable String cpfResponsavel){
        var alunos = this.alunoService.alunosPorCpfResponsavel(cpfResponsavel);
        var alunoDto = alunos.get(0);
        return ResponseEntity.ok().body(alunoDto);
    }
}
