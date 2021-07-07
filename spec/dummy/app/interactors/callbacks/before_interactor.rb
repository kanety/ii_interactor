class Callbacks::BeforeInteractor < IIInteractor::Base
  before_call do
    @context.result = 'before'
  end
end
