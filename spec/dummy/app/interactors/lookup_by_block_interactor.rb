class LookupByBlockInteractor < IIInteractor::Base
  interact do
    IIInteractor::Base.descendants.select { |klass| klass.name =~ /^Lookups::/ }
  end
end
