describe IIInteractor::Base do
  context 'from_return' do
    let :interactor do
      Interfaces::FromReturnInteractor
    end

    it 'sets output context' do
      context = interactor.call(in: 'in')
      expect(context.out).to eq('return value')
    end
  end
end
