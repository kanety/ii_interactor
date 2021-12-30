describe IIInteractor::Base do
  let :interactor do
    BasicInteractor
  end

  it 'calls interactor' do
    expect(interactor.call.success?).to eq(true)
  end

  it 'calls interactor with block' do
    key = nil
    interactor.call do |interactor|
      key = 'value'
    end
    expect(key).to eq('value')
  end

  it 'returns context' do
    expect(interactor.call(input: 'value').input).to eq('value')
  end
end
