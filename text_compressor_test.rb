require 'test/unit'
require './text_compressor.rb'

class TextCompressorTest < Test::Unit::TestCase

  def setup 
    @text = 'first second'
    @compressor = TextCompressor.new('')
  end

  def test_add_word
  	compressor = TextCompressor.new('')
  	compressor.add_word('third')
  	assert_equal compressor.unique, 'third'.split
  	assert_equal compressor.index, [0]
  end

  def test_add_text
    @compressor.add_text(@text)
    assert_equal @compressor.unique, @text.split
    assert_equal @compressor.unique_index_of('first'), 0
    assert_equal @compressor.unique_index_of('second'), 1
  end
 end