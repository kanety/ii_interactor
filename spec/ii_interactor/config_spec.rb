describe IIInteractor::Config do
  context 'configure' do
    before do
      IIInteractor.configure do |config|
        config.lookup_cache = false
      end
    end

    after do
      IIInteractor.configure do |config|
        config.lookup_cache = true
      end
    end

    it 'gets and sets' do
      expect(IIInteractor.config.lookup_cache).to eq(false)
    end
  end
end
