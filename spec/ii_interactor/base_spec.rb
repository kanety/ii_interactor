describe IIInteractor::Base do
  let :interactor do
    SimpleInteractor
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
    expect(interactor.call(key: 'value').key).to eq('value')
  end
end
