class Callbacks::AInteractor < IIInteractor::Base
  context :results, default: []

  before_call do
    @context.results << 'A:before_call'
  end

  around_call do |interactor, block|
    @context.results << 'A:around_call'
    block.call
  end

  after_call do
    @context.results << 'A:after_call'
  end
end
