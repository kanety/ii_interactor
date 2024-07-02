class Interfaces::DefaultInteractor < IIInteractor::Base
  context :in, default: 'default value'
  context :in_proc, default: -> { default_value_method }
  context :in_method, default: :default_value_method

  after_call do
    inform
  end

  private

  def default_value_method
    'default value'
  end
end
