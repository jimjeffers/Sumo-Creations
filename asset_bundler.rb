# Joins multiple assets into a single file. 
# Just like asset caching in Ruby on Rails
# Except we also minify with the yui-compressor!
require "rubygems"
require "yui/compressor" # sudo gem install -r yui-compressor

# Specify paths for your assets.
paths = {
  :js             => "javascripts/",
  :css            => "stylesheets/"
}

# Define your files. The key is the name of the file that will be generated 
# from the combination of files in the array.
js_files = { 
  "cufon.min"     => %w(cufon-yui.js futura_500.font.js),
  "jquery.min"    => %w(jquery-1-1.3.2.min.js jquery.easing.1.2.js jquery.scrollTo-min.js fullscreen-ui.js)
}
css_files = { 
  "screen.min"    => %w(reset.css screen.css),
  "iphone.min"    => %w(iphone.css)
}
        
# Define the javascripts that you'd like to have minified.
minify = %w(jquery.easing.1.2.js fullscreen-ui.js)

# BEGIN ROUTINE!
# Nothing to see here. Just run and wait for the magic to happen.

# Setup a compressor if we need it.
js_compressor = YUI::JavaScriptCompressor.new(:munge => true) if defined?(minify) && minify.length > 0

for new_file, file_set in js_files
  puts "-"*20
  puts "GENERATING #{new_file}.js"
  puts "="*20
  contents = []
  for file in file_set
    content = File.open("#{paths[:js]}/#{file}", 'r').readlines.join("\n")
    if defined?(js_compressor) && minify.include?(file)
      puts "** Minifying: #{file}"
      content = js_compressor.compress(content)
    end
    contents << content
    puts "Appending: #{file}"
  end
  File.open("#{paths[:js]}/#{new_file.to_s}.js", 'w') {|f| f.write(contents.join("\n"))}
  puts "#{new_file}.js complete."
end

# Compress CSS files if they exist.
if defined?(css_files) && css_files.length > 0
  css_compressor = compressor = YUI::CssCompressor.new
  for new_file, file_set in css_files
    puts "-"*20
    puts "GENERATING #{new_file}.css"
    puts "="*20
    contents = []
    for file in file_set
      contents << File.open("#{paths[:css]}/#{file}", 'r').readlines.join("\n")
      puts "Appending: #{file}"
    end
    File.open("#{paths[:css]}/#{new_file.to_s}.css", 'w') {|f| f.write(css_compressor.compress(contents.join("\n")))}
    puts "#{new_file}.css complete."
  end
end