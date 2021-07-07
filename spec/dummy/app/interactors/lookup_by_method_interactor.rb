class LookupByMethodInteractor < IIInteractor::Base
  interact :lookup_interactors

  private

  def lookup_interactors
    IIInteractor.load
    IIInteractor::Base.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
