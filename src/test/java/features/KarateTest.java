package features; //define onde o runner Java está.

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

//classe java que dispara os testes
class KarateTest {

    @Test
    void testParallel() {
        Results results = Runner
                .path("classpath:features") //Diz ao Karate: “Execute todos os .feature que estão no pacote features”
                //.tags("@TesteGeral")
                //.tags("@all")
                //.tags("@registrarUsuario")
                .tags("@token")
                //.tags("@auth")
                //.tags("@livros") //Executa somente cenários ou features marcados com @smoke
//                .outputCucumberJson(true)
                //.tags("@registrarLivros")
                //.tags("@atualizaIsbn")
                //.tags("@ListaUsuario")
                //.tags("@deletarUsuario")
                .parallel(1); //utiliza 5 usuários para realizar os testes
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
