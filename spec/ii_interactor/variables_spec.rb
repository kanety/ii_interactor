describe IIInteractor::Variables do
  let :interactor do
    VariablesInteractor
  end

  it 'sets input context' do
    interactor.call(in: 'in') do |i|
      expect(i.instance_variable_get(:@in)).to eq('in')
    end
  end

  it 'sets output context' do
    context = interactor.call(in: 'in')
    expect(context.out).to eq('in')
  end

  context 'default' do
    let :interactor do
      Variables::DefaultInteractor
    end

    it 'sets default' do
      interactor.call do |i|
        expect(i.instance_variable_get(:@in)).to eq('default value')
      end
    end

    it 'sets default by proc' do
      interactor.call do |i|
        expect(i.instance_variable_get(:@in_proc)).to eq('default value')
      end
    end

    it 'sets default by method' do
      interactor.call do |i|
        expect(i.instance_variable_get(:@in_method)).to eq('default value')
      end
    end
  end

  context 'required' do
    let :interactor do
      Variables::RequiredInteractor
    end

    it 'requires input' do
      expect { interactor.call }.to raise_error(IIInteractor::RequiredContextError)
    end

    it 'requires output' do
      expect { interactor.call(in: 'in') }.to raise_error(IIInteractor::RequiredContextError)
    end

    it 'calls without error' do
      expect { interactor.call(in: 'in', out: 'out') }.not_to raise_error
    end
  end

  context 'from_return' do
    let :interactor do
      Variables::FromReturnInteractor
    end

    it 'sets output context' do
      context = interactor.call(in: 'in')
      expect(context.out).to eq('return value')
    end
  end
end
