describe IIInteractor::Base do
  context 'preorder' do
    before do
      IIInteractor.config.traversal = :preorder
    end

    let :interactor do
      CoactiveInteractor
    end

    it 'traverses preorder' do
      expect(interactor.call.results).to eq(['MAIN', 'A', 'B', 'C'])
    end
  end

  context 'postorder' do
    before do
      IIInteractor.config.traversal = :postorder
    end

    let :interactor do
      CoactiveInteractor
    end

    it 'traverses postorder' do
      expect(interactor.call.results).to eq(['A', 'B', 'C', 'MAIN'])
    end
  end

  context 'inorder' do
    before do
      IIInteractor.config.traversal = :inorder
    end

    let :interactor do
      CoactiveInteractor
    end

    it 'traverses inorder' do
      expect(interactor.call.results).to eq(['A', 'B', 'MAIN', 'C'])
    end
  end
end
