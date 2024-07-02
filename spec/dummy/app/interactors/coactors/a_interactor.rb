class Coactors::AInteractor < IIInteractor::Base
  context :stop, :fail
  context :results, default: [], output: true

  def call
    stop! if @stop == 'A'
    fail! if @fail == 'A'
    @results << 'A'
  end

  def rollback
    @results << 'rollback A'
  end
end
