describe IIInteractor::Base do
  let :interactor do
    SimpleInteractor
  end

  it 'calls interactor' do
    expect(interactor.call.success?).to eq(true)
  end

  it 'calls interactor with block' do
    context = interactor.call { |called, context| context.key = 'value' }
    expect(context.key).to eq('value')
  end

  it 'returns context' do
    expect(interactor.call(key: 'value').key).to eq('value')
  end
end
