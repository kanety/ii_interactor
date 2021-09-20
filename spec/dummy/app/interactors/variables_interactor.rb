class VariablesInteractor < IIInteractor::Base
  context_in :in, required: true
  context_in :in_default, default: 'default'
  context_in :in_default_proc, default: -> { default_value_method }
  context_in :in_default_method, default: :default_value_method
  context_out :out
  context_out :out_return, from_return: true

  def call
    @out = @in
  end

  private

  def default_value_method
    'default'
  end
end
