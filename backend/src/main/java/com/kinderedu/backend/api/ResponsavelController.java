package com.kinderedu.backend.api;

import com.kinderedu.backend.domain.dto.ResponsavelCadastroDTO;
import com.kinderedu.backend.domain.entities.Responsavel;
import com.kinderedu.backend.services.ResponsavelService;
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
@RequestMapping("/responsaveis")
@CrossOrigin("*")
public class ResponsavelController extends BaseController{

    private final ResponsavelService responsavelService;

    @Autowired
    public ResponsavelController(ResponsavelService responsavelService) {
        this.responsavelService = responsavelService;
    }

    @RequestMapping(method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiResponses({@ApiResponse(responseCode = "200")})
    public ResponseEntity<List<Responsavel>> index() {
        var responsaveis = responsavelService.todosOsResponsaveis();
        return ResponseEntity.ok(responsaveis);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity create(@RequestBody ResponsavelCadastroDTO responsavelDTO){
        Responsavel responsavel = this.responsavelService.create(responsavelDTO);
        URI uri = createRouteUri(responsavel.getIdResponsavel());
        return ResponseEntity.created(uri).build();
    }

}
