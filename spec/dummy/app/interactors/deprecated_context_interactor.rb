class DeprecatedContextInteractor < IIInteractor::Base
  context_in :in
  context_out :out
  context_out :out_return, from_return: true

  def call
    @out = 'out'
    'out_return'
  end
end
