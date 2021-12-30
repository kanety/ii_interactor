class Interfaces::FromReturnInteractor < IIInteractor::Base
  context_in :in
  context_out :out, from_return: true

  def call
    'return value'
  end
end
