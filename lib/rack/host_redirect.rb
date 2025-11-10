module Rack
  class HostRedirect
    def initialize(app, redirects = {})
      @app = app
      @redirects = redirects
    end

    def call(env)
      request = Rack::Request.new(env)
      host = request.host

      if @redirects.key?(host)
        target_host = @redirects[host]
        new_url = "#{request.scheme}://#{target_host}#{request.fullpath}"
        [ 301, { "Location" => new_url, "Content-Type" => "text/html" }, [ "Moved Permanently" ] ]
      else
        @app.call(env)
      end
    end
  end
end
