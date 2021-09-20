describe IIInteractor::Variables do
  context 'in' do
    let :interactor do
      VariablesInteractor
    end

    it 'sets input context' do
      i = interactor.new(in: 'in')
      expect(i.instance_variable_get(:@in)).to eq('in')
    end

    it 'sets default' do
      i = interactor.new(in: 'in')
      expect(i.instance_variable_get(:@in_default)).to eq('default')
    end

    it 'sets default by proc' do
      i = interactor.new(in: 'in')
      expect(i.instance_variable_get(:@in_default_proc)).to eq('default')
    end

    it 'sets default by method' do
      i = interactor.new(in: 'in')
      expect(i.instance_variable_get(:@in_default_method)).to eq('default')
    end

    it 'requires input context' do
      expect { interactor.call }.to raise_error(IIInteractor::RequiredContextError)
    end
  end

  context 'out' do
    let :interactor do
      VariablesInteractor
    end

    it 'sets output context' do
      context = interactor.call(in: 'in')
      expect(context.out).to eq('in')
      expect(context.out_return).to eq('in')
    end
  end
end
