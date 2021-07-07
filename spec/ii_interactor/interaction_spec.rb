describe IIInteractor::Interaction do
  context 'interaction' do
    let :interactor do
      SimpleInteractor
    end

    after do
      interactor.clear_interactions
    end
    
    it 'adds interaction' do
      interactor.interact(Interacts::AInteractor)
      expect(interactor.interactions).to eq([Interacts::AInteractor])
    end

    it 'iserts interaction' do
      interactor.interact(Interacts::AInteractor)
      interactor.interact(Interacts::BInteractor, before: Interacts::AInteractor)
      expect(interactor.interactions).to eq([Interacts::BInteractor, Interacts::AInteractor])
    end
  end

  context 'rollback' do
    let :interactor do
      InteractedInteractor
    end

    it 'rollbacks A' do
      expect(interactor.call(fail: 'A').results).to eq([])
    end

    it 'rollbacks B' do
      expect(interactor.call(fail: 'B').results).to eq(['A', 'rollback A'])
    end

    it 'rollbacks MAIN' do
      expect(interactor.call(fail: 'MAIN').results).to eq(['A', 'B', 'rollback B', 'rollback A'])
    end
  end
end
