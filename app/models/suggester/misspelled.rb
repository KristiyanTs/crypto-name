# frozen_string_literal: true

class Suggester
  class Misspelled
    MISSPELLS = [
      %w[oo u],
      %w[qu q],
      %w[ex x],
      %w[ics ix],
      %w[to 2],
      %w[too 2],
      %w[tion shun],
      %w[er r],
      %w[ss s],
      %w[rr r],
      %w[ll l],
      %w[ake eik],
      %w[ake eic],
      %w[y i],
      %w[i y],
      %w[s z],
      %w[c k],
      %w[ape eip],
      %w[ine ain],
      %w[the d],
      %w[su shu],
      %w[aby eiby],
      %w[ide aid],
      %w[ide ait],
      %w[ight it],
      %w[th d],
      %w[th t],
      ['e', ''],
      %w[ck k],
      %w[w u],
      %w[ue u],
      %w[ou au],
      %w[our ur],
      %w[er r],
      %w[or r]
    ].freeze

    def initialize(query)
      @query = query
    end

    def call
      misspell_products
    end

    def misspell_products
      first, *rest = @query.map { |word| misspell(word) + [word] }
      first.product(*rest).map(&:join).uniq
    end

    def misspell(word)
      MISSPELLS.map do |original, fake|
        word.gsub(original, fake)
      end.uniq
    end
  end
end
