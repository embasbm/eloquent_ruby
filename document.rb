require 'text'

class Document
  include Enumerable
  include Text

  attr_accessor :title, :author, :content
  attr_accessor :load_listener
  attr_accessor :save_listener



  def initialize(title, author, content)
    @title = title
    @author = author
    @content = content
  end

  def words
    @content.split
  end

  def word_count
    words.size
  end

  # Using ngram analysis, compute the probability
  # that this document and the one passed in were
  # written by the same person. This algorithm is
  # known to be valid for American English and will
  # probably work for British and Canadian English.
  #
  def same_author_probability( other_document )
    first_doc_ngrams = words.each_cons(2).to_a
    second_doc_ngrams = other_document.words.each_cons(2).to_a
    common_duplas = first_doc_ngrams & second_doc_ngrams
    common_duplas.size / (first_doc_ngrams.size).to_f * 100
  end

  def add_authors( *names )
    @author += " #{names.join(' ')}"
  end

  def average_word_length
    total = words.inject(0.0){ |result, word| word.size + result}
    total / word_count
  end

  def obscure_times!
    @content.gsub!( /\d\d:\d\d (AM|PM)/, '**:** **' )
  end 

  def about_me
    puts "I am #{self}"
    puts "My title is #{self.title}"
    puts "I have #{self.word_count} words"
  end

  def to_s
    "Document: #{title} by #{author}"
  end

  def +(other)
    Document.new(title, author, "#{content} #{other.content}")
  end

  def +@
    Document.new(title, author, "I am sure that #{content}")
  end

  def -@
    Document.new(title, author, "I doubt that #{content}")
  end

  def [](index)
    words[index]
  end

  def size

  end

  def []=(index,value)
    orig = words
    word_count > index ? orig.insert(index,value) : orig.insert(word_count,value)
    @content = orig.join(' ')
  end

  def each_word
    words.each { |word| yield( word ) }
  end

  def each_character
    words.each { |word| word.split('').each {|char| yield( char )} }
  end

  def each_word_pair
    words.each_cons(2) { |array| yield array[0], array[1] }
  end

  def each
    words.each { |word| yield( word ) }
  end

  # def load(path)
  #   @content = File.read(path)
  #   load_listener.on_load(self, path) if load_listener
  # end

  # def save(path)
  #   File.open(path, 'w') {f.print(@contents)}
  #   save_listener.on_save(self, path) if save_listener
  # end

  def on_save(&block)
    @save_listener=block
  end

  def on_load(&block)
    @load_listener=block
  end

  def load(path)
    @content = File.read(path)
    @load_listener.call(self, path) if @load_listener
  end

  def save(path)
    File.open(path, 'w') {|f| f.print(@contents)}
    @save_listener.call(self, path) if @save_listener
  end

  def method_missing(missing, *args)
    candidates = methods_that_sound_like(missing.to_s)

    message = "You called an undefined method: #{missing}"

    unless candidates.empty?
      message += "\nDid you mean #{candidates.join('or')}?"
    end
    raise raise NoMethodError.new(message)
  end

  def methods_that_sound_like(name)
    missing_soundex = Soundex.soundex(name.to_s)
    public_methods.sort.find_all do |existing|
      existing_soundex = Soundex.soundex(existing.to_s)
      missing_soundex == existing_soundex
    end
  end

  def self.const_missing( const_missing)
    msg = %Q{You tried to reference the constant #{const_missing}
              There is no such constant in Document class.
    }
    raise msg
  end
end






my_doc = Document.new( 'Block Based Example', 'russ', '' )
puts my_doc.loquesea = 2
my_doc = Document.new.otra
my_doc = 4














