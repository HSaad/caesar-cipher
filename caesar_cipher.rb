require'sinatra'
require 'sinatra/reloader' if development?

class CaesarCipher

	def shift_lower_letter(char, shiftFactor)
		ascii_value = char.ord + (shiftFactor % 26)
		if (ascii_value > 122)
			return (ascii_value - 26).chr
		end

		return ascii_value.chr
	end

	def shift_upper_letter(char, shiftFactor)
		ascii_value = char.ord + (shiftFactor % 26)
		if (ascii_value > 90)
			return (ascii_value - 26).chr
		end
	
		return (char.ord + shiftFactor).chr
	end

	def create_cipher(string, shiftFactor=0)
		newString = ""

		#iterate over the length of string
		string.scan(/./) do |char|
			if (char.match(/[a-z]/))
				newString +=shift_lower_letter(char, shiftFactor)
			elsif (char.match(/[A-Z]/))
				newString += shift_upper_letter(char, shiftFactor)
			else
				newString += char
			end
		end
		return newString
	end

end

get '/' do
	caesarCipher = CaesarCipher.new()
	shiftFactor = params["shiftFactor"].to_i
	inputCipher = params["inputCipher"].to_s
	message = caesarCipher.create_cipher(inputCipher, shiftFactor)
	
	erb :index, :locals => {:message => message}
end