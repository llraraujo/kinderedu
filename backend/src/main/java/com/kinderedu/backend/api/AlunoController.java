package com.kinderedu.backend.api;


import com.kinderedu.backend.domain.dto.*;
import com.kinderedu.backend.domain.entities.Aluno;
import com.kinderedu.backend.domain.entities.Atividade;
import com.kinderedu.backend.domain.entities.FotoAluno;
import com.kinderedu.backend.services.AlunoService;
import com.kinderedu.backend.services.FotoAlunoService;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.URI;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/alunos")
@CrossOrigin("*")
public class AlunoController extends  BaseController{

    private final AlunoService alunoService;
    private final FotoAlunoService fotoAlunoService;

    public  AlunoController(@Autowired AlunoService alunoService, @Autowired FotoAlunoService fotoAlunoService) {
        this.alunoService = alunoService;
        this.fotoAlunoService = fotoAlunoService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AlunoListagemDTO>> index() {
        var alunos = alunoService.todosOsAlunos();
        return ResponseEntity.ok(alunos);
    }

    @RequestMapping(method =  RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE,produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<AlunoListagemDTO> create(@RequestBody  AlunoCadastroDTO alunoDTO) {
        Aluno aluno = this.alunoService.create(alunoDTO);
        URI uri = createRouteUri(aluno.getIdAluno());
        return ResponseEntity.created(uri).body(new AlunoListagemDTO(aluno));
    }

    @RequestMapping(method =  RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE,produces = MediaType.APPLICATION_JSON_VALUE, path = "/{alunoId}/atividade")
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<Atividade> cadastrarAtividade(
            @PathVariable Long alunoId,
            @RequestParam String cpfProfessor,
            @RequestBody AtividadeCadastroDTO ativadadeDTO
    ){
        Atividade atividade = this.alunoService.cadastrarAtividade(alunoId, cpfProfessor, ativadadeDTO);
        URI uri = createRouteUri(atividade.getIdAtividade());
        return ResponseEntity.created(uri).build();
    }

    @RequestMapping(method =  RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/atividades/{alunoId}")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AtividadeDashboardDTO>> sumarioAtividades(@PathVariable Long alunoId){
        var atividades = this.alunoService.recuperaAtividadesDashboard(alunoId);
        return ResponseEntity.ok(atividades);
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/{alunoId}/atividades")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<AtividadeListagemDTO>> listarAtividadesPorDia(
            @PathVariable Long alunoId,
            @RequestParam String cpfResponsavel,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate data
    ) {
        var atividades = this.alunoService.listarAtividadesPorDia(alunoId, cpfResponsavel, data);
        return ResponseEntity.ok(atividades);
    }

    @RequestMapping(method =  RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/{cpfResponsavel}")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<AlunoProfileDTO> alunosPorCpfResponsavel(@PathVariable String cpfResponsavel){
        var alunos = this.alunoService.alunosPorCpfResponsavel(cpfResponsavel);
        var alunoDto = alunos.get(0);
        return ResponseEntity.ok().body(alunoDto);
    }

    @RequestMapping(
            method = RequestMethod.POST,
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE,
            path = "/{alunoId}/fotos"
    )
    @ApiResponses({@ApiResponse(responseCode = "201")})
    public ResponseEntity<FotoAlunoListagemDTO> cadastrarFoto(
            @PathVariable Long alunoId,
            @RequestParam String cpfProfessor,
            @RequestParam("foto") MultipartFile foto,
            @RequestParam(required = false) String descricao,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime dataHora
    ) {
        FotoAlunoListagemDTO fotoDto = this.fotoAlunoService.cadastrarFoto(
                alunoId,
                cpfProfessor,
                foto,
                descricao,
                dataHora
        );
        URI uri = createRouteUri(fotoDto.getId());
        return ResponseEntity.created(uri).body(fotoDto);
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE, path = "/{alunoId}/fotos")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<FotoAlunoListagemDTO>> listarFotosPorDia(
            @PathVariable Long alunoId,
            @RequestParam String cpfResponsavel,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate data
    ) {
        var fotos = this.fotoAlunoService.listarFotosPorDia(alunoId, cpfResponsavel, data);
        return ResponseEntity.ok(fotos);
    }

    @RequestMapping(method = RequestMethod.GET, path = "/{alunoId}/fotos/{fotoId}/arquivo")
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<byte[]> recuperarArquivoFoto(
            @PathVariable Long alunoId,
            @PathVariable Long fotoId,
            @RequestParam String cpfResponsavel
    ) {
        FotoAluno foto = this.fotoAlunoService.recuperarArquivo(alunoId, fotoId, cpfResponsavel);
        MediaType mediaType = foto.getContentType() != null
                ? MediaType.parseMediaType(foto.getContentType())
                : MediaType.APPLICATION_OCTET_STREAM;

        return ResponseEntity
                .ok()
                .contentType(mediaType)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + foto.getNomeArquivo() + "\"")
                .body(foto.getArquivo());
    }
}
