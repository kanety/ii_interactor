describe IIInteractor::Base do
  context 'default' do
    let :interactor do
      Interfaces::DefaultInteractor
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
end
