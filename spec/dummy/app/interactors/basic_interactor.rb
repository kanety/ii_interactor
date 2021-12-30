class BasicInteractor < IIInteractor::Base
  context_in :input

  def call
    inform
  end
end
