require 'singleton'

class Helper
	include Singleton

	def create_correction ctype, char_index
		{
			ctype: type,
			char_index: char_index
		}		
	end
end

