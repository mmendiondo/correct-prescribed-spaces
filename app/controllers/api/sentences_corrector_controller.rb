class Api::SentencesCorrectorController < ActionController::Base
 
	def update

		# request_params = JSON.parse request.body

		text = params["text"]
		errors = []
		corrections = []
		errors << { case_type: "Should only have one space.", cases: text.scan(/\.  +/)} if text.scan(/\.  +/).length > 0
		errors << { case_type: "Should have one space at least.", cases: text.scan(/\.\w/)} if text.scan(/\.\w/).length > 0

		corrected_text = text.gsub(/\.  +/, ". ").gsub(/(\.)(\w)/, '\1 \2')
		
		errors.each do |error|
			error[:case_fixes] = []
			error[:cases].each do |cse|
				error[:case_fixes] << cse.gsub(/\.  +/, ". ").gsub(/(\.)(\w)/, '\1 \2')
			end
		end

		render :json => {
			text: text,
			corrected_text: corrected_text,
			errors: errors
		}
	end
end

