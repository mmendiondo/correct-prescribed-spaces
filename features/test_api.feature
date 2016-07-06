Feature: test api
  Scenario: correct paragraph
    When I send a GET request to "/api/sentences_corrector" with the following:
      """
      {"text":"Hello World.  Hello.   Hello"}
      """
      Then the response status should be "200"
      And the JSON response should be:
      """
        {
          "phrase": "Hello World.  Hello.   Hello",
          "corrected_phrase":"Hello World. Hello. Hello",
          "corrections":[
                  {
                    "ctype": "extra_blank_space",
                    "sentence_nbr": 2,
                    "sentence": "  Hello",
                    "corrected_sentence": " Hello"},
                  {
                    "ctype": "extra_blank_space",
                    "sentence_nbr":3,
                    "sentence": "   Hello",
                    "corrected_sentence": " Hello"
                  }
          ]
        }
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
          "phrase": "Hello World. Hello. Hello.",
          "corrected_phrase":"Hello World. Hello. Hello.",
          "corrections":[]
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
          "phrase": "Hello World. Hello.                Hello. Helllooooo..     dsadasdasd",
          "corrected_phrase":"Hello World. Hello. Hello. Helllooooo.. dsadasdasd",
          "corrections":[
                  {
                    "ctype": "extra_blank_space",
                    "sentence_nbr": 3,
                    "sentence": "                Hello",
                    "corrected_sentence": " Hello"},
                  {
                    "ctype": "extra_blank_space",
                    "sentence_nbr":6,
                    "sentence": "     dsadasdasd",
                    "corrected_sentence": " dsadasdasd"
                  }
          ]
        }
      """