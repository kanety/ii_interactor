class Interfaces::DefaultInteractor < IIInteractor::Base
  context_in :in, default: 'default value'
  context_in :in_proc, default: -> { default_value_method }
  context_in :in_method, default: :default_value_method

  after_call do
    inform
  end

  private

  def default_value_method
    'default value'
  end
end
