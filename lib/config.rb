require 'yaml'
class Config

  def load path, title
    @config = YAML.load_file(path)[title]  
  end

  def method_missing method
    @config[method.to_s]
  end

end

