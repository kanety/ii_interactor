class Interacts::CInteractor < IIInteractor::Base
  before_call do
    @context.results ||= []
  end

  def call
    fail! if @context.fail == 'C'
    @context.results << 'C'
  end

  def rollback
    @context.results << 'rollback C'
  end
end