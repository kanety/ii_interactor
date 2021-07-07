describe IIInteractor::Lookups::Object do
  context 'object' do
    let :interactor do
      LookupByObjectInteractor
    end

    it 'lookups interactors' do
      expect(interactor.new.lookup).to eq([
        LookupByObject::AInteractor,
        LookupByObject::BInteractor,
        LookupByObject::Inherited::AInteractor,
        LookupByObject::BInteractor
      ])
    end
  end
end
