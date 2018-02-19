# frozen_string_literal: true

class Suggester
  class Similar
    def initialize(query)
      @query = query
    end

    def call
      word_groups = to_word_groups
      mix_groups word_groups
    end

    def to_word_groups
      generated = @query.dup
      counter = 0
      generated.each do |w|
        generated[counter] = [w]
        ['equivalent', 'synonym', 'verb-form', 'verb-stem'].each do |category|
          list = Wordnik.word.get_related(w, type: category, use_canonical: true)
          generated[counter] += list.first['words'].select { |w| w.size < 10 }.map { |w| w.delete(' ') } if list.any?
        end
        counter += 1
      end
      generated
    end

    def mix_groups(word_groups)
      answer = []
      if word_groups.size > 1
        answer = word_groups[0].product(word_groups[1]) if word_groups.size == 2
        answer = word_groups[0].product(word_groups[1], word_groups[2]) if word_groups.size == 3
        answer = word_groups[0].product(word_groups[1], word_groups[3], word_groups[4]) if word_groups.size == 4
        answer = answer.map { |gr| gr.permutation.to_a.map(&:join) }.flatten
      end
      answer
    end
  end
end
