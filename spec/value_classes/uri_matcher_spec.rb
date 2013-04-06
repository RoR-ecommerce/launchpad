require 'spec_helper'

describe UriMatcher do
  describe '::initialize' do
    it 'sets uri' do
      matcher = UriMatcher.new('http://foo.bar')
      expect(matcher.uri).to eq('http://foo.bar')
    end
  end

  describe '#host' do
    it 'returns nil if parse error' do
      matcher = UriMatcher.new('')
      expect(matcher.host).to be_nil
    end

    it 'returns host' do
      matcher = UriMatcher.new('http://foo.bar')
      expect(matcher.host).to eq('foo.bar')
    end
  end

  describe '#port' do
    it 'returns nil if parse error' do
      matcher = UriMatcher.new('')
      expect(matcher.port).to be_nil
    end

    it 'returns standard port' do
      matcher = UriMatcher.new('http://foo.bar')
      expect(matcher.port).to eq(80)
    end

    it 'returns non standard port' do
      matcher = UriMatcher.new('http://foo.bar:8080')
      expect(matcher.port).to eq(8080)
    end
  end

  describe '#eql?' do
    it 'is true if host and port match with same host, port, and path' do
      uri1 = UriMatcher.new('http://foo.bar')
      uri2 = UriMatcher.new('http://foo.bar')
      expect(uri1.eql?(uri2)).to be_true
    end

    it 'is true if host and port match with same host, port but different path' do
      uri1 = UriMatcher.new('http://foo.bar')
      uri2 = UriMatcher.new('http://foo.bar/auth')
      expect(uri1.eql?(uri2)).to be_true
    end

    it 'is true if host and port match with explicit and implicit default port' do
      uri1 = UriMatcher.new('http://foo.bar:80')
      uri2 = UriMatcher.new('http://foo.bar')
      expect(uri1.eql?(uri2)).to be_true
    end

    it 'is false if host and port do not match with same port but different host' do
      uri1 = UriMatcher.new('http://foo.com')
      uri2 = UriMatcher.new('http://foo.bar')
      expect(uri1.eql?(uri2)).to be_false
    end

    it 'is false if host and port do not match with same host but different port' do
      uri1 = UriMatcher.new('http://foo.com')
      uri2 = UriMatcher.new('http://foo.com:8080')
      expect(uri1.eql?(uri2)).to be_false
    end
  end
end
