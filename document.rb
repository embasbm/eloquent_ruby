class Document
  attr_accessor :title, :author, :content

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
end

favorite = Document.new('Favorite', 'Russ', 'Chocolate is best')

favorite[0]= 'Black'
favorite[3]= 'almost the'
favorite[20]= ',I guess.'
puts favorite.content
