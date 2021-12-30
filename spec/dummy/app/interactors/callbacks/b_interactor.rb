class Callbacks::BInteractor < IIInteractor::Base
  context_out :results, default: []

  before_call do
    @context.results << 'B:before_call'
  end

  around_call do |interactor, block|
    @context.results << 'B:around_call'
    block.call
  end

  after_call do
    @context.results << 'B:after_call'
  end
end
