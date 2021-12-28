describe IIInteractor::Callbacks do
  before do
    IIInteractor.config.traversal = :postorder
  end

  let :interactor do
    CallbacksInteractor
  end

  it 'calls callbacks' do
    expect(interactor.call.results).to eq([
      'before_all', 'around_all',
      'A:before_call', 'A:around_call', 'A:after_call',
      'B:before_call', 'B:around_call', 'B:after_call',
      'before_call', 'around_call', 'after_call',
      'after_all'
    ])
  end
end
