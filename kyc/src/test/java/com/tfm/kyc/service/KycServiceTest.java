package com.tfm.kyc.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.kyc.controller.KycController;
import com.tfm.kyc.repository.KycRepository;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.Optional;

import static com.mongodb.internal.connection.tlschannel.util.Util.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

@WebMvcTest(KycController.class)
@Import({ KycService.class })
public class KycServiceTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private KycRepository devicestatusRepository;

    //    @InjectMocks
    @Autowired
    private KycService kycService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testMatchIdDocument() throws Exception {

    String id1 = "02387645193917D";
    String id2 = "02387645193917d";

    Boolean result = kycService.matchIdDocument(id1, id2);

    assertTrue(result);

    }

    @Test
    public void testMatchIdDocumentLength() throws Exception {

            //Da True porque se trunca a 20
        String id1 = "02387645193917D345798111";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatcIdDocumentLength() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "02387645193917D345798111";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchIdDocumentBlankSpace() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "0238764519391 7D345798111";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertFalse(result);

    }

    @Test
    public void testMatchNameValid() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "Alex ";
        String id2 = " aLEx  ";

        Boolean result = kycService.matchName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchNameValidLength() throws Exception {

        //Da False porque se trunca a 40 y los espacios entre palabras son diferentes
        String id1 = "Alex pqeiqwpr papij ihwehfwheifhweifhwjk";
        String id2 = "aLEx pqeiqwpr papij ihwehfwheifhweifhwjk";

        Boolean result = kycService.matchName(id1, id2);

        assertTrue(result);

    }
}
