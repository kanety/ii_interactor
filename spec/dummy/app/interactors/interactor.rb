class Interactor < IIInteractor::Base
  interact Interacts::AInteractor
  interact Interacts::BInteractor
  interact Interacts::CInteractor

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
