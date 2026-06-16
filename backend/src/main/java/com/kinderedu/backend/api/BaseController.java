package com.kinderedu.backend.api;

import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import java.net.URI;

public abstract class BaseController {

    public URI createRouteUri(Long id){
        URI uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}").buildAndExpand(id).toUri();
        return uri;
    }
}
