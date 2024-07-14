describe IIInteractor::Base do
  let :interactor do
    DeprecatedContextInteractor
  end

  it 'calls interactor' do
    context = interactor.call(in: 'in')
    expect(context.in).to eq('in')
    expect(context.out).to eq('out')
    expect(context.out_return).to eq('out_return')
  end
end
