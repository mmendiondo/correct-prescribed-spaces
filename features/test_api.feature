Feature: test api
  Scenario: correct paragraph
    When I send a GET request to "/api/sentences_corrector" with the following:
      """
      {"text":"adolfo.beto.cacho.sbaraglia.     sbarto.        ycono.                  pepe.pepe"}
      """
      Then the response status should be "200"
      And the JSON response should be:
      """
        {"text":"adolfo.beto.cacho.sbaraglia.     sbarto.        ycono.                  pepe.pepe",
          "corrected_text":"adolfo. beto. cacho. sbaraglia. sbarto. ycono. pepe. pepe",
          "errors":
            [
              { "cases":[".     ",".        ",".                  "],
                "case_type":"Should only have one space.",
                "case_fixes":[". ",". ",". "]
              },
              { "cases":[".b",".c",".s",".p"],
                "case_type":"Should have one space at least.",
                "case_fixes":[". b",". c",". s",". p"]
              }]}
      """

  Scenario: correct paragraph good text
    When I send a GET request to "/api/sentences_corrector" with the following:
      """
      {"text":"Hello World. Hello. Hello."}
      """
      Then the response status should be "200"
      And the JSON response should be:
      """
         {
          "text":"Hello World. Hello. Hello.",
          "corrected_text":"Hello World. Hello. Hello.",
          "errors":[]
        }
      """
  Scenario: correct paragraph really wrong text
    When I send a GET request to "/api/sentences_corrector" with the following:
      """
      {"text":"Hello World. Hello.                Hello. Helllooooo..     dsadasdasd"}
      """
      Then the response status should be "200"
      And the JSON response should be:
      """
        {
          "text": "Hello World. Hello.                Hello. Helllooooo..     dsadasdasd",
          "corrected_text":"Hello World. Hello. Hello. Helllooooo.. dsadasdasd",
          "errors":
            [
              { "cases":[".                ",".     "],
                "case_type":"Should only have one space.",
                "case_fixes":[". ",". "]
              }
            ]
        }
      """
