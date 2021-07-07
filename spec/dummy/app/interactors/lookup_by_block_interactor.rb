class LookupByBlockInteractor < IIInteractor::Base
  interact do
    IIInteractor.load
    IIInteractor::Base.descendants.select { |klass| klass.name =~ /^Lookups::/ }.sort_by(&:name)
  end
end
