class Callbacks::AfterInteractor < IIInteractor::Base
  after_call do
    @context.result = 'after'
  end
end
