def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}"), __FILE__)
  put ERB.new(erb).result(binding), to
end

