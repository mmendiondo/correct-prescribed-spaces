class Api::SentencesCorrectorController < ActionController::Base
 
	def update
		request_params = JSON.parse request.body.read
	  	text = request_params["text"]

		splitted_text = text.split(".") #Dots are gone
		corrections = []
		@regex = /  +/i

		splitted_text.each_with_index do |sentence, index|
			correction = check_only_one_space_after_period(sentence, index+1) #check if more than one space at begining
			corrections.push correction if !correction.nil?
		end		

	  	render :json => {
	  		phrase: text, 
	  		corrected_phrase: text.gsub(@regex, " "),
	  		corrections: corrections
	  	}
	end

	private
		
		def check_only_one_space_after_period sentence, nbr
			correction = {
							ctype: "extra_blank_space", 
							sentence_nbr: nbr, 
							sentence: sentence, 
							corrected_sentence: sentence.gsub(@regex, " ")
						  } if !sentence.match(@regex).nil?
		end

end


