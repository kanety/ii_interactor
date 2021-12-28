class Callbacks::BInteractor < IIInteractor::Base
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
