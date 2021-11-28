class Coactors::AInteractor < IIInteractor::Base
  context_in :stop, :fail
  context_out :results, default: []

  def call
    stop! if @stop == 'A'
    fail! if @fail == 'A'
    @results << 'A'
  end

  def rollback
    @results << 'rollback A'
  end
end
