class SimpleInteractor < IIInteractor::Base
  def call
    fail! if @context.fail
  end
end
