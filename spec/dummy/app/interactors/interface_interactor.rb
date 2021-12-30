class InterfaceInteractor < IIInteractor::Base
  context_in :in
  context_out :out

  def call
    @out = @in
  end
end
