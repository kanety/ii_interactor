class Variables::RequiredInteractor < IIInteractor::Base
  context_in :in, required: true
  context_out :out, required: true

  def call
  end
end
