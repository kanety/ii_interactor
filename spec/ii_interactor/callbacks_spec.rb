describe IIInteractor::Callbacks do
  context 'before' do
    let :interactor do
      Callbacks::BeforeInteractor
    end

    it 'calls callback' do
      expect(interactor.call.result).to eq('before')
    end
  end

  context 'after' do
    let :interactor do
      Callbacks::AfterInteractor
    end

    it 'calls callback' do
      expect(interactor.call.result).to eq('after')
    end
  end

  context 'around' do
    let :interactor do
      Callbacks::AroundInteractor
    end

    it 'calls callback' do
      expect(interactor.call.result).to eq('around')
    end
  end
end
