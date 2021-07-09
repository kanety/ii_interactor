class Interactor < IIInteractor::Base
  interact Interacts::AInteractor
  interact Interacts::BInteractor
  interact Interacts::CInteractor

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
