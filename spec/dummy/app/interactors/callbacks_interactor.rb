class CallbacksInteractor < IIInteractor::Base
  coact Callbacks::AInteractor
  coact Callbacks::BInteractor

  context_out :results, default: []

  before_all do
    @context.results << 'before_all'
  end

  around_all do |interactor, block|
    @context.results << 'around_all'
    block.call
  end

  after_all do
    @context.results << 'after_all'
  end

  before_call do
    @context.results << 'before_call'
  end

  around_call do |interactor, block|
    @context.results << 'around_call'
    block.call
  end

  after_call do
    @context.results << 'after_call'
  end
end
