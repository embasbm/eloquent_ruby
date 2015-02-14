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
end

doc = Document.new( 'Hamlet', 'Shakespeare', 'To be or seem and behave...' )

doc.add_authors('Mary','Joseph')
doc.add_authors(['Phil','Alan'])

p "#{doc.author.gsub(' ',',')} are the authors of #{doc.title}"
p "#{doc.average_word_length.round} is the #{'average_word_length'.gsub('_',' ')}"



