class Interfaces::RequiredInteractor < IIInteractor::Base
  context :in, required: true
  context :out, required: true

  def call
  end
end
