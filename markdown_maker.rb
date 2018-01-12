require 'reverse_markdown'
require 'json'
require 'httparty'


file =  File.read('posts.json')
data_hash = JSON.parse(file)
content = []
counter = 0
days = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)


 data_hash["items"].each do |k,v|  
   item = k["content"] 
   header = "### #{k["title"]} \n"
   date = DateTime.parse(k["published"]).to_date
   day = date.wday
   day = days[day]
   date = "#### #{day}, " + "#{date.strftime("%B %d, %Y")} \n"
   
   content = ReverseMarkdown.convert(item, unknown_tags: :bypass, github_flavored: true)
   
       post_content = File.new("#{k["published"][0...10]}.md", "w")

       post_content.write(date)
       post_content.write(header)
       post_content.write(content)
       counter += 1
 end
 
 # post_content = File.new("post_content", "w")
 # post_content.write(content)
# items = Array.new
# counter = 0
# # puts items[0]
# items.each do |k|
#   if k["__text"] 
#     f = File.new("file_#{counter}", "w")

#     # content = Kramdown::Document.new(html_doc, :input=> 'html').remove_html_tags.to_kramdown
#     f.write(html_doc)
#   end
# counter += 1
# end
# 
# puts Kramdown::Document.new(item, :input=> 'html').to_kramdown