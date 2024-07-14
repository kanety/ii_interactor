class Interfaces::FromReturnInteractor < IIInteractor::Base
  context :in
  context :out, output: :return

  def call
    'return value'
  end
end
