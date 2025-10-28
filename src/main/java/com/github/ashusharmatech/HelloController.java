package com.github.ashusharmatech;

import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;

@Controller("/hello")
public class HelloController {

    @Get("/")
    public String index() {
        return "Hello from Micronaut!";
    }

    @Get("/{name}")
    public String greet(String name) {
        return "Hello " + name + "!";
    }
}
