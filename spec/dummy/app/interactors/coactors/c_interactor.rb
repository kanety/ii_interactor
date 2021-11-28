class Coactors::CInteractor < IIInteractor::Base
  context_in :stop, :fail
  context_out :results, default: []

  def call
    stop! if @stop == 'C'
    fail! if @fail == 'C'
    @results << 'C'
  end

  def rollback
    @results << 'rollback C'
  end
end
