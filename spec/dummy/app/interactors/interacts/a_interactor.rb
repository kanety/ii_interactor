class Interacts::AInteractor < IIInteractor::Base
  before_call do
    @context.results ||= []
  end

  def call
    stop! if @context.stop == 'A'
    fail! if @context.fail == 'A'
    @context.results << 'A'
  end

  def rollback
    @context.results << 'rollback A'
  end
end
