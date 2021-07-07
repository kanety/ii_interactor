class Interacts::BInteractor < IIInteractor::Base
  before_call do
    @context.results ||= []
  end

  def call
    fail! if @context.fail == 'B'
    @context.results << 'B'
  end

  def rollback
    @context.results << 'rollback B'
  end
end
