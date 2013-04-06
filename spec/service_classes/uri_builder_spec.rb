require 'spec_helper'

describe UriBuilder do
  describe '::initialize' do
    it 'sets uri and fragments' do
      builder = UriBuilder.new('http://yahoo.com', foo: 1, bar: 2)
      expect(builder.uri).to eq('http://yahoo.com')
      expect(builder.fragments).to eq({ foo: 1, bar: 2 })
    end
  end

  describe '#build' do
    it 'returns uri back if no query string to build' do
      builder = UriBuilder.new('http://yahoo.com')
      expect(builder.build).to eq('http://yahoo.com')
    end

    it 'creates uri with ?' do
      builder = UriBuilder.new('http://yahoo.com', foo: 1, bar: 2)
      expect(builder.build).to eq('http://yahoo.com?bar=2&foo=1')
    end

    it 'creates uri with &' do
      builder = UriBuilder.new('http://yahoo.com?q=qwerty', foo: 1, bar: 2)
      expect(builder.build).to eq('http://yahoo.com?q=qwerty&bar=2&foo=1')
    end
  end
end
