module ApplicationHelper
	def show_alert
		if flash[:alert] then
			html = <<-HTML
				<div class="alert alert-warning fade in">
				#{flash[:alert]}
	    		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  			</div>
  			HTML
  			html.html_safe
		end
	end

	def show_error
		if flash[:error] then
			html = <<-HTML
				<div class="alert alert-error fade in">
				#{flash[:error]}
	    		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  			</div>
  			HTML
  			html.html_safe
		end
	end

	def show_notice
		if flash[:notice] then
			html = <<-HTML
				<div class="alert alert-notice fade in">
				#{flash[:notice]}
	    		<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	  			</div>
  			HTML
  			html.html_safe
		end
	end

	def capitalize_words_in_text(text)
		text = text.strip unless text.strip.nil?
		return text.split(" ").each {|s| s.capitalize}.inject(""){|x,y|x<<" "<<y}
	end
end
