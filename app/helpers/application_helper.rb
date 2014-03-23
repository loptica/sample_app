module ApplicationHelper
  def full_title(page_title)
  	base_title = "Sample App"
  	if page_title.empty?
  	 base_title # nama je page_title empty
  	else
  		"#{base_title} | #{page_title}"
  	end
  end 
end
