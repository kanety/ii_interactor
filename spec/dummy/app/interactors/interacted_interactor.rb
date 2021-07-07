class InteractedInteractor < IIInteractor::Base
  interact Interacts::AInteractor
  interact Interacts::BInteractor

  before_call do
    @context.results ||= []
  end

  def call
    fail! if @context.fail == 'MAIN'
    @context.results << 'MAIN'
  end

  def rollback
    @context.results << 'rollback MAIN'
  end
end
