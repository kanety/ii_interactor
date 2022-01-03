describe IIInteractor::Base do
  context 'required' do
    let :interactor do
      Interfaces::RequiredInteractor
    end

    it 'requires input' do
      expect { interactor.call }.to raise_error(Coactive::MissingContextError)
    end

    it 'requires output' do
      expect { interactor.call(in: 'in') }.to raise_error(Coactive::MissingContextError)
    end

    it 'calls without error' do
      expect { interactor.call(in: 'in', out: 'out') }.not_to raise_error
    end
  end
end
