require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params)
    # debugger
    @req = req
    @res = res
    @already_built_response = false
    @params = params.merge(req.params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    unless already_built_response?
      @res.set_header('Location', url)
      @res.status = 302
      @already_built_response = true
      session.store_session(@res)
    else
      raise "YOU SILLY SILLY PERSON"
    end
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    unless already_built_response?
      @res.set_header("Content-Type", content_type)
      @res.write(content)
      @already_built_response = true
      session.store_session(@res)
    else
      raise "YOU SILLY SILLY PERSON"
    end
  end

  # cats_controller2.render(:index)

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    # controller_name = self.class.to_s
    # underscore_name = controller_name.underscore
    string_template_name = template_name.to_s
    underscore_name = (/(\w+)Controller/).match(self.class.to_s)[1].downcase+'_controller'
    path = File.join("views", underscore_name, string_template_name + ".html.erb")
    read_file = File.read(path)

    badass_solution = ERB.new(read_file).result(binding)

    render_content(badass_solution, "text/html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    Router.send(name)
  end
end
