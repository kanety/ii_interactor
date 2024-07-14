class InterfaceInteractor < IIInteractor::Base
  context :in
  context :out, output: true

  def call
    @out = @in
  end
end
