describe IIInteractor::Base do
  let :interactor do
    SimpleInteractor
  end

  it 'calls interactor' do
    expect(interactor.call(key: 'value').key).to eq('value')
  end

  it 'fails interactor' do
    expect(interactor.call(fail: true).failed?).to eq(true)
  end
end
