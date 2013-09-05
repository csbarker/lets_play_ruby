# Source: http://forrst.com/posts/Simple_WEBRick_server_to_run_your_ruby_scripts_l-DXR
# 1st create webrick.rb file
#START - File webrick.rb

require 'webrick'

include WEBrick

require 'erb'

WEBrick::HTTPUtils::DefaultMimeTypes['rhtml'] = 'text/html'

server = WEBrick::HTTPServer.new :Port => 3000, :DocumentRoot => Dir.pwd

class CustomServlet < HTTPServlet::AbstractServlet

        def do_GET(request, response)
                response.status = 200 # Success
                File.open(request.path.to_s.sub(/\//, ''),'r') do |f|
                        @template = ERB.new(f.read)
                end
                response.body = @template.result(binding)
                response['Content-Type'] = "text/html"
        end

        # Respond with an HTTP POST just as we do for the HTTP GET.
        alias :do_POST :do_GET
end

server.mount('', CustomServlet)

yield server if block_given?

trap 'INT' do server.shutdown end

server.start

#END - File webrick.rb