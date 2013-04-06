require 'spec_helper'

describe UriRedirector do
  describe '::initialize' do
    it 'sets safe_uri and unsafe_uri as UriMatcher instances' do
      redirector = UriRedirector.new('http://foo.com', 'http://bar.com')
      expect(redirector.safe_uri).to be_kind_of(UriMatcher)
      expect(redirector.unsafe_uri).to be_kind_of(UriMatcher)
    end
  end

  describe '#uri' do
    it 'runs UriBuilder#build' do
      UriBuilder.any_instance.should_receive(:build).and_return('http://foo.com')
      redirector = UriRedirector.new('http://foo.com', 'http://bar.com')
      expect(redirector.uri).to eq('http://foo.com')
    end
  end

  describe '#base_uri' do
    it 'returns safe_uri if no unsafe_uri' do
      redirector = UriRedirector.new('http://foo.com', '')
      expect(redirector.base_uri).to eq('http://foo.com')
    end

    it 'returns unsafe_uri if both bases match' do
      redirector = UriRedirector.new('http://foo.com', 'http://bar.com')
      redirector.should_receive(:match?).and_return(true)
      expect(redirector.base_uri).to eq('http://bar.com')
    end

    it 'returns safe_uri if bases do not match' do
      redirector = UriRedirector.new('http://foo.com', 'http://bar.com')
      redirector.should_receive(:match?).and_return(false)
      expect(redirector.base_uri).to eq('http://foo.com')
    end
  end
end
