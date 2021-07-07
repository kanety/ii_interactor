class Callbacks::AroundInteractor < IIInteractor::Base
  around_call do |interactor, block|
    @context.result = 'around'
  end
end
