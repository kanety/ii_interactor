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

    it 'inserts interaction' do
      interactor.interact(Interacts::AInteractor)
      interactor.interact(Interacts::BInteractor, before: Interacts::AInteractor)
      expect(interactor.interactions).to eq([Interacts::BInteractor, Interacts::AInteractor])
    end
  end
end
