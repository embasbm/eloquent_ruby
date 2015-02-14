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
end

doc = Document.new( 'Hamlet', 'Shakespeare', 'To be or seem and behave...' )

doc2 = Document.new( 'Quijote', 'Cervantes', 'To be or seem and ' )

p "#{doc.title} and #{doc2.title} have #{doc.same_author_probability(doc2)}% probability to be written by the same author: #{doc.author}"