describe IIInteractor::Base do
  let :interactor do
    InterfaceInteractor
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
end
