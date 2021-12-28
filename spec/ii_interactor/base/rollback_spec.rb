describe IIInteractor::Base do
  before do
    IIInteractor.config.traversal = :postorder
  end

  context 'stop' do
    let :interactor do
      Interactor
    end

    it 'stops interactor' do
      context = interactor.call(stop: 'B')
      expect(context.results).to eq(['A', 'B'])
      expect(context.stopped?).to eq(true)
    end
  end

  context 'fail' do
    let :interactor do
      Interactor
    end

    it 'fails interactor' do
      context = interactor.call(fail: 'B')
      expect(context.results).to eq(['A', 'rollback A'])
      expect(context.failure?).to eq(true)
    end
  end

  context 'rollback' do
    let :interactor do
      Interactor
    end

    it 'rollbacks A' do
      expect(interactor.call(fail: 'A').results).to eq([])
    end

    it 'rollbacks B' do
      expect(interactor.call(fail: 'B').results).to eq(['A', 'rollback A'])
    end

    it 'rollbacks C' do
      expect(interactor.call(fail: 'C').results).to eq(['A', 'B', 'rollback B', 'rollback A'])
    end

    it 'rollbacks MAIN' do
      expect(interactor.call(fail: 'MAIN').results).to eq(['A', 'B', 'C', 'rollback C', 'rollback B', 'rollback A'])
    end
  end
end
