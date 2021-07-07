describe IIInteractor::Lookups::Name do
  context 'name' do
    let :interactor do
      LookupByNameInteractor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to include(Lookups::AInteractor, Lookups::BInteractor)
    end
  end

  context 'name2' do
    let :interactor do
      LookupByName2Interactor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to include(Lookups::BInteractor, Lookups::CInteractor)
    end
  end
end
