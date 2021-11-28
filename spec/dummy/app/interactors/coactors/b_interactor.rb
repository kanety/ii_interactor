class Coactors::BInteractor < IIInteractor::Base
  context_in :stop, :fail
  context_out :results, default: []

  def call
    stop! if @stop == 'B'
    fail! if @fail == 'B'
    @results << 'B'
  end

  def rollback
    @results << 'rollback B'
  end
end
