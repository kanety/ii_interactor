class CoactiveInteractor < IIInteractor::Base
  coact Coactors::AInteractor
  coact Coactors::BInteractor
  coact Coactors::CInteractor

  context :fail
  context :results, default: [], output: true

  def call
    fail! if @fail == 'MAIN'
    @results << 'MAIN'
  end

  def rollback
    @results << 'rollback MAIN'
  end
end
