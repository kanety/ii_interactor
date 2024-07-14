class Coactors::CInteractor < IIInteractor::Base
  context :stop, :fail
  context :results, default: [], output: true

  def call
    stop! if @stop == 'C'
    fail! if @fail == 'C'
    @results << 'C'
  end

  def rollback
    @results << 'rollback C'
  end
end
