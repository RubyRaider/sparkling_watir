class BasePage
  attr_reader :app

  def initialize(app)
    @app = app
  end
end
