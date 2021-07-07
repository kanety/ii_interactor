class LookupByMethodInteractor < IIInteractor::Base
  interact :lookup_interactors

  private

  def lookup_interactors
    IIInteractor::Base.descendants.select { |klass| klass.name =~ /^Lookups::/ }
  end
end
