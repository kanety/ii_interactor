describe IIInteractor::Lookup do
  context 'basic' do
    let :interactor do
      LookupInteractor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to eq([Lookups::AInteractor, Lookups::BInteractor])
    end

    it 'lookups all interactors' do
      expect(interactor.new.lookup_all).to eq([Lookups::AInteractor, Lookups::BInteractor])
    end
  end

  context 'lookup block' do
    let :interactor do
      LookupByBlockInteractor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to eq([Lookups::AInteractor, Lookups::BInteractor, Lookups::CInteractor])
    end
  end

  context 'lookup method' do
    let :interactor do
      LookupByMethodInteractor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to eq([Lookups::AInteractor, Lookups::BInteractor, Lookups::CInteractor])
    end
  end
end
