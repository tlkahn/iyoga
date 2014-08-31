module ApplicationHelper
	def capitalize_words_in_text(text)
		text = text.strip unless text.strip.nil?
		return text.split(" ").each {|s| s.capitalize}.inject(""){|x,y|x<<" "<<y}
	end
end
