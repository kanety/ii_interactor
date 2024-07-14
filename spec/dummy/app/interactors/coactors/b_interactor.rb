class Coactors::BInteractor < IIInteractor::Base
  context :stop, :fail
  context :results, default: [], output: true

  def call
    stop! if @stop == 'B'
    fail! if @fail == 'B'
    @results << 'B'
  end

  def rollback
    @results << 'rollback B'
  end
end
