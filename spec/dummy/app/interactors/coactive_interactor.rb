class CoactiveInteractor < IIInteractor::Base
  coact Coactors::AInteractor
  coact Coactors::BInteractor
  coact Coactors::CInteractor

  context_in :fail
  context_out :results, default: []

  def call
    fail! if @fail == 'MAIN'
    @results << 'MAIN'
  end

  def rollback
    @results << 'rollback MAIN'
  end
end
